import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {
    id: root

    property vector3d lightPosition: Qt.vector3d(8.0, 10.0, 8.0)
    property vector3d lightIntensity: Qt.vector3d(1.0, 1.0, 1.0)
    readonly property Camera lightCamera: lightCamera
    readonly property matrix4x4 lightViewProjection: lightCamera.projectionMatrix.times(lightCamera.viewMatrix)

    Camera {
        id: lightCamera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 60
        aspectRatio: 1
        nearPlane : 0.1
        farPlane : 200.0
        position: root.lightPosition
        viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
        upVector: Qt.vector3d(0.0, 1.0, 0.0)
    }
}
