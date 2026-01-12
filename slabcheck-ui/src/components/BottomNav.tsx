"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

export default function BottomNav() {
  const pathname = usePathname();

  const base =
    "flex flex-col items-center justify-center flex-1 py-4 text-sm border-t shadow-lg";
  const active = "text-blue-500 font-bold";
  const inactive = "text-gray-800 font-bold";

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-gray-100 shadow-lg">
      <div className="max-w-md mx-auto flex">
        <Link
          href="/"
          className={`${base} ${pathname === "/" ? active : inactive}`}
        >
          Recently Searched
        </Link>

        <Link
          href="/verify"
          className={`${base} ${pathname === "/verify" ? active : inactive}`}
        >
          Verify a Slab
        </Link>
      </div>
    </nav>
  );
}
