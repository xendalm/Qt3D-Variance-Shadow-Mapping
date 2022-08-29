import Qt3D.Core 2.0
import Qt3D.Render 2.0

Entity {
    id: root


    Transform {
        id: carTransform
    }

    ShMapMaterial {
        id: bodyMaterial
        effect: shMapEffect
        ambient: "black"
        diffuse: Qt.rgba(0.5270588, 0.03137255, 0.03137255, 1.0)
        specular: Qt.rgba(0.7686275, 0.6196079, 0.3568628, 1.0)
        shininess: 150
        //ambient: Qt.rgba(0.1, 0.02, 0.04, 1.0)
        //ambientReflection: 0.4
        //diffuse: Qt.rgba(0.7, 0.2, 0.25, 1.0)
        //diffuseReflection: 0.7
        //specular: Qt.rgba(0.7, 0.2, 0.25, 1.0)
        //specularReflection: 1.0
        //shininess: 30
        renderShadows: true
    }

    ShMapMaterial {
        id: body2Material
        effect: shMapEffect
        ambient: Qt.rgba(0.05, 0.05, 0.05, 1.0)
        ambientReflection: 0.7
        diffuse: Qt.rgba(0.25, 0.25, 0.25, 1.0)
        diffuseReflection: 0.7
        specular: Qt.rgba(0.3, 0.3, 0.3, 1.0)
        specularReflection: 0.4
        shininess: 50
        renderShadows: true
    }

    ShMapMaterial {
        id: bottomMaterial
        effect: shMapEffect
        ambient: Qt.rgba(0.0, 0.0, 0.0, 1.0)
        ambientReflection: 0.7
        diffuse: Qt.rgba(0.1, 0.1, 0.1, 1.0)
        diffuseReflection: 0.7
        specular: Qt.rgba(0.2, 0.2, 0.2, 1.0)
        specularReflection: 0.5
        shininess: 100
        renderShadows: true
    }

    ShMapMaterial {
        id: interiorMaterial
        effect: shMapEffect
        ambient: Qt.rgba(0.05, 0.05, 0.05, 1.0)
        ambientReflection: 0.7
        diffuse: Qt.rgba(0.25, 0.25, 0.25, 1.0)
        diffuseReflection: 0.7
        specular: Qt.rgba(0.3, 0.3, 0.3, 1.0)
        specularReflection: 0.4
        shininess: 50
        renderShadows: true
    }

    ShMapMaterial {
        id: wheelsMaterial
        effect: shMapEffect
        ambient: Qt.rgba(0.0, 0.0, 0.0, 1.0)
        ambientReflection: 0.7
        diffuse: Qt.rgba(0.2, 0.2, 0.2, 1.0)
        diffuseReflection: 0.7
        specular: Qt.rgba(1.0, 1.0, 1.0, 1.0)
        specularReflection: 0.15
        shininess: 7
        renderShadows: true
    }

    ShMapMaterial {
        id: lights2Material
        effect: shMapEffect
        ambient: Qt.rgba(0.2, 0.2, 0.2, 1.0)
        ambientReflection: 0.3
        diffuse: Qt.rgba(0.67, 0.85, 0.9, 1.0)
        diffuseReflection: 0.45
        specular: Qt.rgba(1.0, 1.0, 1.0, 1.0)
        specularReflection: 0.45
        shininess: 35
        renderShadows: true
    }

    ShMapMaterial {
        id: logo2Material
        effect: shMapEffect
        ambient: Qt.rgba(0.1, 0.1, 0.1, 1.0)
        ambientReflection: 0.4
        diffuse: Qt.rgba(0.3, 0.3, 0.3, 1.0)
        diffuseReflection: 0.7
        specular: Qt.rgba(0.3, 0.3, 0.3, 1.0)
        specularReflection: 1.0
        shininess: 7
        renderShadows: true
    }

    ShMapMaterial {
        id: windowsMaterial
        effect: shMapEffect
        ambient: Qt.rgba(0.05, 0.2, 0.2, 1.0)
        ambientReflection: 0.2
        diffuse: Qt.rgba(1.0, 1.0, 1.0, 1.0)
        diffuseReflection: 0.0
        specular: Qt.rgba(0.67, 0.85, 0.9, 1.0)
        specularReflection: 0.9
        shininess: 15
        opacity: 0.12
        renderShadows: true
    }

    Entity {
        id: body

        Mesh {
            id: bodyMesh
            source: "qrc:/objects/car-parts/body.obj"
        }

        components: [bodyMesh, bodyMaterial]
    }

    Entity {
        id: body2

        Mesh {
            id: body2Mesh
            source: "qrc:/objects/car-parts/body2.obj"
        }

        components: [body2Mesh, body2Material]
    }

    Entity {
        id: bottom

        Mesh {
            id: bottomMesh
            source: "qrc:/objects/car-parts/bottom.obj"
        }

        components: [bottomMesh, bottomMaterial]
    }

    Entity {
        id: interior

        Mesh {
            id: interiorMesh
            source: "qrc:/objects/car-parts/interior.obj"
        }

        components: [interiorMesh, interiorMaterial]
    }

    Entity {
        id: lights

        Mesh {
            id: lightsMesh
            source: "qrc:/objects/car-parts/lights.obj"
        }

        components: [lightsMesh, body2Material]
    }

    Entity {
        id: lights2

        Mesh {
            id: lights2Mesh
            source: "qrc:/objects/car-parts/lights2.obj"
        }

        components: [lights2Mesh, lights2Material]
    }

    Entity {
        id: logo1

        Mesh {
            id: logo1Mesh
            source: "qrc:/objects/car-parts/logo1.obj"
        }

        ShMapTexMaterial {
            id: logo1Material
            effect: shMapTexEffect
            source: "qrc:/objects/logo.png"
            renderShadows: true
        }

        components: [logo1Mesh, logo1Material]
    }

    Entity {
        id: logo2

        Mesh {
            id: logo2Mesh
            source: "qrc:/objects/car-parts/logo2.obj"
        }

        components: [logo2Mesh, logo2Material]
    }

    Entity {
        id: wheels

        Mesh {
            id: wheelsMesh
            source: "qrc:/objects/car-parts/wheels.obj"
        }

        components: [wheelsMesh, wheelsMaterial]
    }

    Entity {
        id: windows

        Mesh {
            id: windowsMesh
            source: "qrc:/objects/car-parts/windows.obj"
        }

        components: [windowsMesh, windowsMaterial]
    }

    components: [
        carTransform
    ]
}
