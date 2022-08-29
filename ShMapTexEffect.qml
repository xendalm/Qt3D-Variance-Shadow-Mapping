import Qt3D.Core 2.0
import Qt3D.Render 2.0

Effect {
    id: root

    property Texture2D shadowTexture
    property Texture2D tempShadowTexture
    property Texture2D displayTexture
    property ShMapLight light
    property real shadowTextureResolution
    property real shadowBlurAmount: 1.0
    property int samplesNumberPCF: 1

    parameters: [
        Parameter { name: "lightViewProjection"; value: root.light.lightViewProjection },
        Parameter { name: "lightPosition";  value: root.light.lightPosition },
        Parameter { name: "lightIntensity"; value: root.light.lightIntensity },
        Parameter { name: "displayTexture"; value: root.displayTexture },
        Parameter { name: "displayTextureSize"; value: Qt.vector2d(window.width, window.height) },
        Parameter { name: "xfilterShadowMapTexture"; value: root.shadowTexture },
        Parameter { name: "yfilterShadowMapTexture"; value: root.tempShadowTexture },
        Parameter { name: "shadowMapTexture"; value: root.shadowTexture },
        Parameter { name: "shadowMapTextureSize"; value: Qt.vector2d(root.shadowTextureResolution, root.shadowTextureResolution) },
        Parameter { name: "blurScale"; value: (1.0/root.shadowTextureResolution) * root.shadowBlurAmount},
        Parameter { name: "samplesNumberPCF"; value: root.samplesNumberPCF}
    ]

    techniques: [
        Technique {
            graphicsApiFilter {
                api: GraphicsApiFilter.OpenGL
                profile: GraphicsApiFilter.CoreProfile
                majorVersion: 3
                minorVersion: 2
            }

            renderPasses: [
                RenderPass {
                    filterKeys: [ FilterKey { name: "pass"; value: "shadowmap" } ]

                    shaderProgram: ShaderProgram {
                        vertexShaderCode:   loadSource("qrc:/shaders/shadowmap.vert")
                        fragmentShaderCode: loadSource("qrc:/shaders/shadowmap.frag")
                    }
                },
                RenderPass {
                    filterKeys: [ FilterKey { name: "pass"; value: "xfilter" } ]

                    shaderProgram: ShaderProgram {
                        vertexShaderCode:   loadSource("qrc:/shaders/xfilter.vert")
                        fragmentShaderCode: loadSource("qrc:/shaders/xfilter.frag")
                    }
                },
                RenderPass {
                    filterKeys: [ FilterKey { name: "pass"; value: "yfilter" } ]

                    shaderProgram: ShaderProgram {
                        vertexShaderCode:   loadSource("qrc:/shaders/yfilter.vert")
                        fragmentShaderCode: loadSource("qrc:/shaders/yfilter.frag")
                    }
                },
                RenderPass {
                    filterKeys: [ FilterKey { name : "pass"; value : "display" } ]

                    shaderProgram: ShaderProgram {
                        vertexShaderCode:   loadSource("qrc:/shaders/renderingShadows.vert")
                        fragmentShaderCode: loadSource("qrc:/shaders/texRenderingShadows.frag")
                    }

                    renderStates: [
                        BlendEquation {
                            blendFunction: BlendEquation.Add
                        },
                        BlendEquationArguments {
                            sourceRgb: BlendEquationArguments.One
                            destinationRgb: BlendEquationArguments.OneMinusSourceAlpha
                            sourceAlpha: BlendEquationArguments.One
                            destinationAlpha: BlendEquationArguments.OneMinusSourceAlpha
                        }
                    ]
                },
                RenderPass {
                     filterKeys: [ FilterKey { name: "pass"; value: "forward" } ]

                     shaderProgram: ShaderProgram {
                         vertexShaderCode:   loadSource("qrc:/shaders/fxaa.vert")
                         fragmentShaderCode: loadSource("qrc:/shaders/fxaa.frag")
                     }
                 }
            ]
        }
    ]
}
