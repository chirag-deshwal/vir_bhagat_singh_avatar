"use client";

import { useFrame } from "@react-three/fiber";
import { Environment, PerspectiveCamera, Float, Stars } from "@react-three/drei";
import { useRef, useLayoutEffect } from "react";
import * as THREE from "three";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { Model } from "./Model";
import { EffectComposer, Noise, Vignette } from "@react-three/postprocessing";

export const Experience = () => {
    const cameraRef = useRef<THREE.PerspectiveCamera>(null!);
    const sceneRef = useRef<THREE.Group>(null!);
    const tl = useRef<gsap.core.Timeline>(null!);

    useLayoutEffect(() => {
        gsap.registerPlugin(ScrollTrigger);

        tl.current = gsap.timeline({
            scrollTrigger: {
                trigger: "body",
                start: "top top",
                end: "bottom bottom",
                scrub: 1.5, // Slower scrub for heavier feel
            },
        });

        // --- CINEMATIC CAMERA PATH ---

        // Initial: Front view (z=8)

        // Move 1: Dive in and tilt (Hero to Introduction)
        tl.current.to(cameraRef.current.position, {
            x: 0,
            y: 0,
            z: 4,
            duration: 2,
            ease: "power2.inOut",
        });

        // Move 2: Side angled view (Selected Works)
        tl.current.to(cameraRef.current.position, {
            x: -4,
            y: 2,
            z: 4,
            duration: 3,
            ease: "power1.inOut",
        }, ">-0.5");

        tl.current.to(cameraRef.current.rotation, {
            x: 0,
            y: -0.5,
            z: 0,
            duration: 3,
            ease: "power1.inOut",
        }, "<");

        // Move 3: Look up from below (Contact / Footer)
        tl.current.to(cameraRef.current.position, {
            x: 0,
            y: -3,
            z: 2,
            duration: 3,
            ease: "power2.inOut",
        }, ">-0.5");

        tl.current.to(cameraRef.current.rotation, {
            x: 1.0,
            y: 0,
            z: 0,
            duration: 3,
            ease: "power2.inOut",
        }, "<");


        return () => {
            tl.current?.kill();
            ScrollTrigger.getAll().forEach((t) => t.kill());
        };
    }, []);

    return (
        <>
            {/* Cinematic Camera */}
            <PerspectiveCamera
                makeDefault
                ref={cameraRef}
                position={[0, 0, 8]}
                fov={35} // Narrower FOV for cinematic look
            />

            {/* Atmospheric Lighting */}
            <ambientLight intensity={0.2} />
            <pointLight position={[10, 10, 10]} intensity={1.5} color="#4f46e5" />
            <pointLight position={[-10, -10, -5]} intensity={1} color="#ec4899" />
            <Environment preset="city" />

            {/* Background Elements */}
            <Stars radius={100} depth={50} count={5000} factor={4} saturation={0} fade speed={1} />

            {/* Main Scene Content */}
            <group ref={sceneRef}>
                <Float speed={2} rotationIntensity={0.5} floatIntensity={0.5}>
                    <Model scale={0.8} />
                </Float>
            </group>

            {/* Post Processing for Film Look */}
            <EffectComposer enableNormalPass={false}>
                <Noise opacity={0.05} />
                <Vignette eskil={false} offset={0.1} darkness={1.1} />
            </EffectComposer>
        </>
    );
};
