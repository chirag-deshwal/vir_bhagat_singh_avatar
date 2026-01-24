"use client";

import { useFrame } from "@react-three/fiber";
import { useGLTF, Float, MeshDistortMaterial } from "@react-three/drei";
import { useRef } from "react";
import * as THREE from "three";

export function Model(props: any) {
    // If you have a model, un-comment lines below:
    // const { nodes, materials } = useGLTF('/model.glb')

    const meshRef = useRef<THREE.Mesh>(null!);

    useFrame((state) => {
        const t = state.clock.getElapsedTime();
        if (meshRef.current) {
            // Add some extra subtle motion
            meshRef.current.rotation.x = Math.cos(t / 4) / 8;
            meshRef.current.rotation.y = Math.sin(t / 4) / 8;
            meshRef.current.position.y = (1 + Math.sin(t / 1.5)) / 10;
        }
    });

    return (
        <group {...props} dispose={null}>
            <Float
                speed={4} // Animation speed, defaults to 1
                rotationIntensity={1} // XYZ rotation intensity, defaults to 1
                floatIntensity={2} // Up/down float intensity, works like a multiplier with floatingRange,defaults to 1
                floatingRange={[0, 1]} // Range of y-axis values the object will float within, defaults to [-0.1,0.1]
            >
                <mesh ref={meshRef} scale={1.5}>
                    <torusKnotGeometry args={[1, 0.3, 100, 16]} />
                    <MeshDistortMaterial
                        color="#8855ff"
                        attach="material"
                        distort={0.5} // Strength, 0 disables the effect (default=1)
                        speed={2} // Speed (default=1)
                        roughness={0.2}
                        metalness={0.8}
                    />
                </mesh>
            </Float>

            {/* 
        Example of how to render a loaded GLB model:
        <primitive object={nodes.Scene} />
      */}
        </group>
    );
}

// Preload the model if we had one
// useGLTF.preload('/model.glb')
