import type { Metadata } from "next";
import { Inter } from "next/font/google"; // Changed from localFont
import "./globals.css";

const inter = Inter({ subsets: ["latin"] }); // Initialize Inter font

export const metadata: Metadata = {
  title: "Vir Bhagat Singh",
  description: "An immersive 3D tribute to the revolutionary hero Bhagat Singh.",
};

import SmoothScroll from "@/components/dom/SmoothScroll";
// ... imports

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${inter.className} antialiased`}
      >
        <SmoothScroll>{children}</SmoothScroll>
      </body>
    </html>
  );
}
