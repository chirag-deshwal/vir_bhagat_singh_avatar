"use client";

import { useEffect } from "react";
import { storyChapters } from "@/data/bhagat_singh_story";

export default function Overlay() {

    useEffect(() => {
        // Initialize Unicorn Studio
        const initUnicorn = () => {
            // @ts-ignore
            const u = window.UnicornStudio;
            if (u && u.init) {
                u.init();
            } else {
                // @ts-ignore
                window.UnicornStudio = { isInitialized: false };
                const script = document.createElement("script");
                script.src = "https://cdn.jsdelivr.net/gh/hiunicornstudio/unicornstudio.js@v2.0.3/dist/unicornStudio.umd.js";
                script.onload = () => {
                    // @ts-ignore
                    if (window.UnicornStudio && window.UnicornStudio.init) {
                        // @ts-ignore
                        window.UnicornStudio.init();
                    }
                };
                document.head.appendChild(script);
            }
        };

        initUnicorn();
    }, []);

    return (
        <div className="absolute top-0 left-0 w-full z-10 pointer-events-none">

            {/* Header */}
            <header className="fixed top-0 left-0 w-full p-8 md:p-12 flex justify-between items-center mix-blend-exclusion text-white z-50 pointer-events-auto">
                <div className="text-xl md:text-2xl font-bold tracking-tighter cursor-pointer">
                    {/* <a href="/">Vir Bhagat Singh</a> */}
                </div>
                <nav className="hidden md:flex space-x-8 text-sm font-medium tracking-widest">
                    <a href="/story" className="hover:opacity-50 transition-opacity">STORY</a>
                </nav>
                <button className="md:hidden text-sm font-bold uppercase">Menu</button>
            </header>

            {/* Hero Section */}
            <section className="h-screen w-full flex flex-col justify-center px-8 md:px-24 relative overflow-hidden">
                <div className="z-20 relative mix-blend-exclusion text-white">
                    <h1 className="text-[12vw] leading-[0.85] font-black tracking-[-0.05em]">
                        BHAGAT
                    </h1>
                    <h1 className="text-[12vw] leading-[0.85] font-black tracking-[-0.05em] ml-[10vw]">
                        SINGH
                    </h1>
                    <div className="mt-12 flex items-center gap-4">
                        <div className="h-[1px] w-12 bg-white"></div>
                        <p className="text-sm md:text-lg font-bold tracking-wide uppercase max-w-sm text-transparent bg-clip-text bg-gradient-to-b from-[#FF9933] via-[#FFFFFF] to-[#138808]">
                            INQUILAB ZINDABAD (Long Live Revolution)
                        </p>
                    </div>
                </div>

                {/* Unicorn Studio Embed - Positioned Absolute Right */}
                <div className="absolute right-0 top-1/2 -translate-y-1/2 z-10 pointer-events-auto origin-right scale-75 md:scale-90 lg:scale-100">
                    <div data-us-project="Wg0EX4torxDPnfR78B5S" style={{ width: '1440px', height: '900px' }}></div>
                </div>
            </section>

            {/* Introduction */}
            <section className="h-screen w-full flex flex-col justify-center items-end px-8 md:px-24">
                <div className="mix-blend-exclusion text-white text-right max-w-2xl">
                    <p className="text-3xl md:text-5xl font-light leading-tight">
                        "They may kill me, but they cannot kill my <span className="font-bold italic">ideas</span>. They can crush my body, but they will not be able to crush my <span className="font-bold italic">spirit</span>."
                    </p>
                </div>
            </section>

            {/* Story Line - Large vertical list */}
            <section className="min-h-screen w-full flex flex-col justify-center px-8 md:px-24 py-24">
                <h2 className="text-sm font-bold uppercase tracking-widest mb-12 mix-blend-exclusion text-white">STORY LINE</h2>
                <div className="flex flex-col space-y-8 mix-blend-exclusion text-white pointer-events-auto">
                    {storyChapters.map((chapter, i) => (
                        <a
                            key={chapter.id}
                            href={`/story?chapter=${chapter.id}`}
                            className="group flex flex-col md:flex-row md:items-center justify-between border-t border-white/20 py-8 hover:bg-white/5 transition-colors cursor-pointer"
                        >
                            <h3 className="text-4xl md:text-6xl font-bold tracking-tighter group-hover:translate-x-4 transition-transform duration-500 uppercase">
                                {chapter.title}
                            </h3>
                            <span className="text-sm font-mono mt-2 md:mt-0 opacity-0 group-hover:opacity-100 transition-opacity">
                                0{i + 1} — {chapter.year}
                            </span>
                        </a>
                    ))}
                </div>
            </section>

            {/* Footer / Contact */}
            <section className="h-screen w-full flex flex-col justify-end pb-24 px-8 md:px-24">
                <div className="mix-blend-exclusion text-white">
                    <h2 className="text-[8vw] font-black tracking-tighter leading-none mb-8">
                        LONG LIVE REVOLUTION
                    </h2>
                    <div className="flex flex-col md:flex-row justify-between items-start md:items-end border-t border-white pt-8">
                        <div className="space-y-2 text-lg">
                            <p>An immersive tribute.</p>
                            <p>1907 – 1931</p>
                        </div>
                        <div className="flex space-x-6 mt-8 md:mt-0 font-bold uppercase tracking-widest pointer-events-auto">
                            <a href="https://www.linkedin.com/in/iamrahuldeshwal/" target="_blank" rel="noopener noreferrer" className="hover:underline">LinkedIn</a>
                            <a href="https://github.com/chirag-deshwal" target="_blank" rel="noopener noreferrer" className="hover:underline">Github</a>
                            <a href="https://x.com/iamrahuldeshwal" target="_blank" rel="noopener noreferrer" className="hover:underline">X</a>
                        </div>
                    </div>
                </div>
            </section>

        </div>
    );
}

