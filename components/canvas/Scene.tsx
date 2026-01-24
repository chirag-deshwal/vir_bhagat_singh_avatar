"use client";

import { Canvas } from "@react-three/fiber";
import { Suspense } from "react";
import { Experience } from "./Experience";
import { Preload } from "@react-three/drei";

export default function Scene() {
    return (
        <div id="canvas-container">
            <Canvas
                gl={{ antialias: true, alpha: true }}
                dpr={[1, 1.5]} // Optimization for high DPI screens
            >
                <Suspense fallback={null}>
                    <Experience />
                    <Preload all />
                </Suspense>
            </Canvas>
        </div>
    );
}
