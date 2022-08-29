import Qt3D.Core 2.0
import Qt3D.Render 2.0

RenderSettings {
    id: root

    property alias viewCamera: viewCameraSelector.camera
    property alias displayCamera: displayCameraSelector.camera
    property alias lightCamera: lightCameraSelector.camera
    property alias xfilterCamera: xfilterCameraSelector.camera
    property alias yfilterCamera: yfilterCameraSelector.camera
    readonly property Texture2D shadowTexture: shadowMap
    readonly property Texture2D xfilterShadowTexture: xfilterShadowMap
    readonly property Texture2D displayTexture: displayTexture
    property real shadowTextureResolution
    property color backgroungColor

    activeFrameGraph: Viewport {
        normalizedRect: Qt.rect(0.0, 0.0, 1.0, 1.0)

        RenderSurfaceSelector {
            RenderPassFilter {
                matchAny: [ FilterKey { name: "pass"; value: "shadowmap" } ]

                RenderTargetSelector {
                    target: RenderTarget {
                        attachments: [
                            RenderTargetOutput {
                                objectName: "shadowMap"
                                attachmentPoint: RenderTargetOutput.Color0
                                texture: Texture2D {
                                    id: shadowMap
                                    width: root.shadowTextureResolution
                                    height: root.shadowTextureResolution
                                    format: Texture.RG32F
                                    magnificationFilter: Texture.Linear
                                    minificationFilter: Texture.Linear
                                    wrapMode {
                                        x: WrapMode.ClampToEdge
                                        y: WrapMode.ClampToEdge
                                    }
                                }
                            },
                            RenderTargetOutput {
                                attachmentPoint: RenderTargetOutput.DepthStencil
                                texture: Texture2D{
                                    width: root.shadowTextureResolution
                                    height: root.shadowTextureResolution
                                    format: Texture.D24S8
                                }
                            }
                        ]
                    }
                    ClearBuffers {
                        buffers: ClearBuffers.ColorDepthBuffer

                        CameraSelector {
                            id: lightCameraSelector
                        }
                    }
                }
            }

            RenderPassFilter {
                matchAny: [ FilterKey { name: "pass"; value: "xfilter" } ]

                RenderTargetSelector {
                    target: RenderTarget {
                        attachments: [
                            RenderTargetOutput {
                                objectName: "xfilterShadowMap"
                                attachmentPoint: RenderTargetOutput.Color0
                                texture: Texture2D {
                                    id: xfilterShadowMap
                                    width: root.shadowTextureResolution
                                    height: root.shadowTextureResolution
                                    format: Texture.RG32F
                                    magnificationFilter: Texture.Linear
                                    minificationFilter: Texture.Linear
                                    wrapMode {
                                        x: WrapMode.ClampToEdge
                                        y: WrapMode.ClampToEdge
                                    }
                                }
                            }
                        ]
                    }
                    ClearBuffers {
                        buffers: ClearBuffers.ColorBuffer
                        CameraSelector {
                            id: xfilterCameraSelector
                        }
                    }
                }
            }

            RenderPassFilter {
                matchAny: [ FilterKey { name: "pass"; value: "yfilter" } ]

                RenderTargetSelector {
                    target: RenderTarget {
                        attachments: [
                            RenderTargetOutput {
                                objectName: "yfilterShadowMap"
                                attachmentPoint: RenderTargetOutput.Color0
                                texture: shadowMap
                            }
                        ]
                    }
                    ClearBuffers {
                        buffers: ClearBuffers.ColorBuffer
                        CameraSelector {
                            id: yfilterCameraSelector
                        }
                    }
                }
            }

            RenderPassFilter {
                matchAny: [ FilterKey { name: "pass"; value: "display" } ]

                RenderTargetSelector {
                    target: RenderTarget {
                        attachments: [
                            RenderTargetOutput {
                                objectName: "display"
                                attachmentPoint: RenderTargetOutput.Color0
                                texture: Texture2D {
                                    id: displayTexture
                                    width: window.width
                                    height: window.height
                                    format: Texture.RGBA32F
                                    magnificationFilter: Texture.Linear
                                    minificationFilter: Texture.Linear
                                    wrapMode {
                                        x: WrapMode.ClampToEdge
                                        y: WrapMode.ClampToEdge
                                    }
                                }
                            },
                            RenderTargetOutput {
                                attachmentPoint: RenderTargetOutput.DepthStencil
                                texture: Texture2D{
                                    width: window.width
                                    height: window.height
                                    format: Texture.D24S8
                                }
                            }
                        ]
                    }
                    ClearBuffers {
                        clearColor: backgroungColor
                        buffers: ClearBuffers.ColorDepthBuffer
                        CameraSelector {
                            id: viewCameraSelector
                        }
                    }
                }
            }

            RenderPassFilter {
                matchAny: [ FilterKey { name: "pass"; value: "forward" } ]

                ClearBuffers {
                    clearColor: backgroungColor
                    buffers: ClearBuffers.ColorDepthBuffer
                    CameraSelector {
                        id: displayCameraSelector
                    }
                }
            }
        }
    }
}
