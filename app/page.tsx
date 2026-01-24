import Scene from "@/components/canvas/Scene";
import Overlay from "@/components/dom/Overlay";

export default function Home() {
  return (
    <main className="relative w-full min-h-screen">
      <Scene />
      <Overlay />
    </main>
  );
}
