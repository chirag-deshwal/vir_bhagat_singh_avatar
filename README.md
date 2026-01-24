# Vir Bhagat Singh - Immersive 3D Tribute

An interactive, cinematic 3D web experience honoring the legendary revolutionary **Bhagat Singh**. This project merges historical storytelling with modern creative development technologies to create an immersive digital tribute.

## 🌟 Features

-   **Cinematic 3D Experience**: A fully rendered 3D background using **Three.js** and **React Three Fiber**, featuring atmospheric lighting, floating particles, and post-processing effects (Noise, Vignette).
-   **Scroll-Driven Storytelling**: Seamless camera transitions and animations driven by scroll interactions using **GSAP** and **ScrollTrigger**.
-   **"Classified Record" Interface**: A dedicated biography section designed like a historical dossier, featuring deep-linking to specific chapters of Bhagat Singh's life.
-   **Premium Aesthetics**: High-impact typography, smooth smooth-scrolling (Lenis), and a "mix-blend-mode" overlay system for a modern, artistic look.
-   **Responsive Design**: Fully optimized for both desktop and mobile devices.

## 🛠️ Tech Stack

-   **Framework**: [Next.js 16](https://nextjs.org/) (App Router)
-   **Language**: TypeScript
-   **3D Engine**: [React Three Fiber](https://docs.pmnd.rs/react-three-fiber) (@react-three/fiber, @react-three/drei)
-   **Animations**: [GSAP](https://gsap.com/) (GreenSock Animation Platform)
-   **Styling**: [Tailwind CSS v4](https://tailwindcss.com/)
-   **Smooth Scroll**: [Lenis](https://github.com/darkroomengineering/lenis)
-   **Deployment**: Vercel / GitHub Pages

## 📂 Project Structure

```bash
├── app/
│   ├── globals.css        # Global styles & font variables
│   ├── layout.tsx         # Root layout with SmoothScroll wrapper
│   ├── page.tsx           # Main entry point (Scene + Overlay)
│   └── story/             # Dedicated story page route
├── components/
│   ├── canvas/            # 3D Scene Components
│   │   ├── Experience.tsx # Main 3D logic (Camera, Lights, Animation)
│   │   ├── Model.tsx      # 3D Objects/Models
│   │   └── Scene.tsx      # Canvas setup
│   └── dom/               # HTML UI Components
│       ├── Overlay.tsx    # Main landing page UI
│       └── SmoothScroll.tsx # Lenis integration
├── data/
│   └── bhagat_singh_story.ts # Structured historical data
└── public/                # Static assets (fonts, images)
```

## 🚀 Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/chirag-deshwal/vir_bhagat_singh_3d.git
    cd vir_bhagat_singh_3d
    ```

2.  **Install dependencies:**
    ```bash
    npm install
    # or
    yarn install
    ```

3.  **Run the development server:**
    ```bash
    npm run dev
    ```

4.  **Open locally:**
    Visit [http://localhost:3000](http://localhost:3000) in your browser.

## 🎨 Creative Direction

The design ethos is **"Revolutionary Modernism"**. We use:
-   **Typography**: Large, bold, uppercase fonts to signify strength.
-   **Color Palette**: Monochromatic dark mode with `orange-500` accents representing the revolutionary spirit.
-   **Motion**: Heavy, reliable scroll physics to give weight to the historical content.

## 📜 data Source

Historical facts and chapters are curated from verified sources, including Wikipedia and historical archives, structured in `data/bhagat_singh_story.ts`.

---

*"They may kill me, but they cannot kill my ideas."* — **Bhagat Singh**
