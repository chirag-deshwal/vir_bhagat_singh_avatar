"use client";

import { storyChapters } from "@/data/bhagat_singh_story";
import { useState, useEffect, Suspense } from "react";
import Link from "next/link";
import { useSearchParams } from "next/navigation";

function StoryPageContent() {
    const params = useSearchParams();

    const [activeChapter, setActiveChapter] = useState(storyChapters[0]);
    const [showDetails, setShowDetails] = useState(false);

    // Initial load effect
    useEffect(() => {
        const chapterId = params.get("chapter");
        if (chapterId) {
            const found = storyChapters.find(c => c.id === chapterId);
            if (found) {
                setActiveChapter(found);
                setShowDetails(true);
            }
        }
    }, [params]);

    return (
        <div className="min-h-screen w-full bg-neutral-950 text-neutral-100 font-sans selection:bg-orange-500 selection:text-white">
            {/* Navigation */}
            <nav className="fixed top-0 left-0 w-full p-8 z-50 flex justify-between items-center mix-blend-difference">
                <Link href="/" className="text-xl font-bold tracking-tighter hover:opacity-70 transition-opacity">
                    ← BACK TO HOME
                </Link>
                <div className="text-sm uppercase tracking-widest hidden md:block">
                    The Life of a Revolutionary
                </div>
            </nav>

            <div className="flex flex-col md:flex-row h-screen overflow-hidden">

                {/* Left Side: Chapter List */}
                <div className="w-full md:w-1/3 h-1/2 md:h-full overflow-y-auto border-r border-neutral-800 p-8 pt-32 bg-neutral-900/50 backdrop-blur-sm">
                    <div className="space-y-4">
                        {storyChapters.map((chapter, index) => (
                            <button
                                key={chapter.id}
                                onClick={() => {
                                    setActiveChapter(chapter);
                                    setShowDetails(false);
                                }}
                                className={`w-full text-left p-6 border transition-all duration-300 group relative overflow-hidden ${activeChapter.id === chapter.id
                                        ? "border-orange-500 bg-orange-500/10"
                                        : "border-neutral-800 hover:border-neutral-600 hover:bg-neutral-800"
                                    }`}
                            >
                                <span className="text-xs font-mono text-neutral-500 mb-2 block group-hover:text-orange-400">
                                    REF. 0{index + 1}
                                </span>
                                <h3 className="text-2xl font-bold uppercase tracking-wide group-hover:translate-x-2 transition-transform">
                                    {chapter.title}
                                </h3>
                                <p className="text-sm font-mono text-neutral-400 mt-2">{chapter.year}</p>
                            </button>
                        ))}
                    </div>
                </div>

                {/* Right Side: Content Viewer */}
                <div className="w-full md:w-2/3 h-1/2 md:h-full relative flex flex-col justify-center p-8 md:p-24 bg-[url('/noise.png')]">

                    <div className="max-w-2xl relative z-10">
                        <div className="inline-block px-3 py-1 border border-orange-500 text-orange-500 text-xs font-mono mb-6 uppercase tracking-widest">
                            Classified Record
                        </div>

                        <h1 className="text-5xl md:text-7xl font-black uppercase tracking-tighter mb-8 leading-none">
                            {activeChapter.title}
                        </h1>

                        <p className="text-xl md:text-2xl text-neutral-300 font-light leading-relaxed mb-12 border-l-2 border-neutral-700 pl-6">
                            {activeChapter.content}
                        </p>

                        {/* Toggle Details Button */}
                        <button
                            onClick={() => setShowDetails(!showDetails)}
                            className="group flex items-center space-x-4 text-orange-500 hover:text-orange-400 transition-colors"
                        >
                            <div className={`w-8 h-8 border border-current flex items-center justify-center transition-transform duration-300 ${showDetails ? 'rotate-45' : ''}`}>
                                +
                            </div>
                            <span className="text-sm font-bold uppercase tracking-widest">
                                {showDetails ? "Hide Classified Details" : "View Classified Details"}
                            </span>
                        </button>

                        {/* Details Panel (Collapsible) */}
                        <div className={`mt-8 overflow-hidden transition-all duration-500 ${showDetails ? 'max-h-96 opacity-100' : 'max-h-0 opacity-0'}`}>
                            <div className="bg-neutral-900 border border-neutral-800 p-8 space-y-4">
                                {activeChapter.details.map((detail, i) => (
                                    <div key={i} className="flex items-start space-x-4">
                                        <span className="text-orange-500 font-mono mt-1">0{i + 1} //</span>
                                        <p className="text-neutral-300 font-light">{detail}</p>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>

                    {/* Background Decorative Elements */}
                    <div className="absolute top-0 right-0 w-full h-full pointer-events-none opacity-20 bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-neutral-800 to-transparent" />
                    <div className="absolute bottom-12 right-12 font-mono text-9xl text-neutral-800 font-bold opacity-20 select-none">
                        {activeChapter.year.split('–')[0]}
                    </div>

                </div>
            </div>
        </div>
    );
}

export default function StoryPage() {
    return (
        <Suspense fallback={<div className="bg-black h-screen w-full flex items-center justify-center text-white">Loading Records...</div>}>
            <StoryPageContent />
        </Suspense>
    )
}
