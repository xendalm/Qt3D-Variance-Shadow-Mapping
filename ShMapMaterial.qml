import Qt3D.Core 2.0
import Qt3D.Render 2.0

Material {
    id: root
    property color ambient: Qt.rgba(0.1, 0.1, 0.1, 1.0)
    property color diffuse: Qt.rgba(0.7, 0.7, 0.7, 1.0)
    property color specular: Qt.rgba(0.5, 0.5, 0.5, 1.0)
    property real shininess: 150.0
    property real opacity: 1.0
    property real ambientReflection: 1.0
    property real diffuseReflection: 1.0
    property real specularReflection: 1.0
    property bool renderShadows: false

    parameters: [
        Parameter { name: "ambientColor"; value: Qt.vector3d(root.ambient.r, root.ambient.g, root.ambient.b) },
        Parameter { name: "diffuseColor"; value: Qt.vector3d(root.diffuse.r, root.diffuse.g, root.diffuse.b) },
        Parameter { name: "specularColor"; value: Qt.vector3d(root.specular.r, root.specular.g, root.specular.b) },
        Parameter { name: "shininess"; value: root.shininess },
        Parameter { name: "opacity"; value: root.opacity },
        Parameter { name: "ka"; value: root.ambientReflection },
        Parameter { name: "kd"; value: root.diffuseReflection },
        Parameter { name: "ks"; value: root.specularReflection },
        Parameter { name: "renderShadows"; value: root.renderShadows}
    ]
}
