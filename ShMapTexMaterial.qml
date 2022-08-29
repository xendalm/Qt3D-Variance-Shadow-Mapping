import Qt3D.Core 2.0
import Qt3D.Render 2.0

Material {
    id: root

    property color ambient: Qt.rgba(0.1, 0.1, 0.1, 1.0)
    property color specular: Qt.rgba(0.5, 0.5, 0.5, 1.0)
    property real shininess: 100.0
    property real opacity: 1.0
    property alias source: diffuseTextureImage.source
    property bool renderShadows: false

    parameters: [
        Parameter { name: "ambientCollor"; value: Qt.vector3d(root.ambient.r, root.ambient.g, root.ambient.b) },
        Parameter { name: "specularCollor"; value: Qt.vector3d(root.specular.r, root.specular.g, root.specular.b) },
        Parameter { name: "shininess"; value: root.shininess },
        Parameter { name: "opacity"; value: root.opacity },
        Parameter {
            name: "diffuseTexture";
            value: Texture2D {
                id: diffuseTexture
                TextureImage {
                    id: diffuseTextureImage
                    source: diffuseMap
                }
                minificationFilter: Texture.LinearMipMapLinear
                magnificationFilter: Texture.Linear
                wrapMode {
                    x: WrapMode.Repeat
                    y: WrapMode.Repeat
                }
                generateMipMaps: true
                maximumAnisotropy: 16.0
            }
        },
        Parameter { name: "renderShadows"; value: root.renderShadows}
    ]
}
