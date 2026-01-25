import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "export",  // <=== Enables static HTML export
  images: {
    unoptimized: true, // <=== Required for static export
  },
  trailingSlash: true, // <=== Helps with GitHub Pages 404s
  // If deploying to https://<USERNAME>.github.io/<REPO_NAME>/
  // Set basePath to '/<REPO_NAME>'
  // basePath: "/vir_bhagat_singh_3d", 
};

export default nextConfig;
