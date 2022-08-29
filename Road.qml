import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {
    id: root

    Mesh {
        id: roadMesh
        source: "qrc:/objects/road.obj"
    }

    Transform {
        id: roadMeshTransform
    }

    ShMapTexMaterial {
        id: roadMaterial
        effect: shMapTexEffect
        specular: Qt.rgba(0, 0, 0, 1.0)
        ambient: Qt.rgba(0.15, 0.15, 0.15, 1.0)
        source: "qrc:/objects/road.png"
        renderShadows: true
    }

    components: [
        roadMesh,
        roadMeshTransform,
        roadMaterial
    ]
}
