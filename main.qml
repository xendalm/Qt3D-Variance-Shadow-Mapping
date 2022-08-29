import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

Entity {
    id: rootEntity

    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 60.0
        aspectRatio: window.width / window.height
        nearPlane: 0.1
        farPlane: 1000.0
        position: Qt.vector3d(10.0, 6.0, 30.0)
        viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
        upVector: Qt.vector3d(0.0, 1.0, 0.0)
    }

    OrbitCameraController {
        camera: camera
        lookSpeed: 150
        linearSpeed: 50
    }

    Camera {
        id: displayCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 60.0
        aspectRatio: window.width / window.height
        nearPlane: 0.00001
        farPlane: 1.0
        position: Qt.vector3d(0.0, 0.0001, 0.0)
        viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
        upVector: Qt.vector3d(0.0, 1.0, 0.0)
    }
    Entity {
        id: displayPlane
        PlaneMesh {
            id: planeMesh
            width: 0.001
            height: width
            meshResolution: Qt.size(2, 2)
        }
        ShMapMaterial {
            id: planeMaterial
            effect: shMapEffect
        }
        components: [
            planeMesh,
            planeMaterial
        ]
    }

    ShMapLight {
        id: shLightEntity
    }

    components: [
        ShMapFrameGraph {
            id: shMapFrameGraph
            displayCamera: displayCamera//camera
            viewCamera: camera
            lightCamera: shLightEntity.lightCamera
            xfilterCamera: shLightEntity.lightCamera
            yfilterCamera: shLightEntity.lightCamera
            shadowTextureResolution: 1024.0
            backgroungColor: Qt.rgba(0.5, 0.8, 0.98, 1.0)
        },
        InputSettings { }
    ]

    ShMapEffect {
        id: shMapEffect
        light: shLightEntity
        displayTexture: shMapFrameGraph.displayTexture
        shadowTexture: shMapFrameGraph.shadowTexture
        tempShadowTexture: shMapFrameGraph.xfilterShadowTexture
        shadowTextureResolution: shMapFrameGraph.shadowTextureResolution
        shadowBlurAmount: 1.25
        samplesNumberPCF: 1
    }

    ShMapTexEffect {
        id: shMapTexEffect
        light: shLightEntity
        displayTexture: shMapFrameGraph.displayTexture
        shadowTexture: shMapFrameGraph.shadowTexture
        tempShadowTexture: shMapFrameGraph.xfilterShadowTexture
        shadowTextureResolution: shMapFrameGraph.shadowTextureResolution
        shadowBlurAmount: 1.25
        samplesNumberPCF: 1
    }


    Entity {
        id: objects

        Road {}

        Car {}

        Transform {
            id: objectsTransform
        }
        components: [objectsTransform]
    }

}
