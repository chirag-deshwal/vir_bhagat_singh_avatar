import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "export",  // <=== Enables static HTML export
  images: {
    unoptimized: true, // <=== Required for static export
  },
  // If deploying to https://<USERNAME>.github.io/<REPO_NAME>/
  // Set basePath to '/<REPO_NAME>'
  // basePath: "/vir_bhagat_singh_3d", 
};

export default nextConfig;
