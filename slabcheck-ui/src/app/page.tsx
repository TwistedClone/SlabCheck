"use client";

import { useEffect, useState } from "react";
import { fetchSlabs } from "@/lib/api";

export default function Home() {
  const [slabs, setSlabs] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchSlabs()
      .then(setSlabs)
      .finally(() => setLoading(false));
  }, []);

  if (loading) return <div className="p-6">Loading slabs...</div>;

  if (slabs.length === 0)
    return (
      <div className="p-6 text-gray-500">
        No slabs found — verify one to add it.
      </div>
    );

  return (
    <div className="p-6 space-y-4">
      <h1 className="text-2xl font-bold">Recently Verified</h1>

      <div className="space-y-4">
        {slabs.map((slab) => (
          <div
            key={slab.id}
            className="p-4 rounded-lg shadow-sm bg-gray-800 border-gray-200 border-s"
          >
            <div className="font-semibold">
              {slab.card_name} ({slab.grading_company})
            </div>
            <div className="text-gray-700">Cert #{slab.cert_number}</div>

            <div className="mt-2">
              <span className="font-bold">Grade: </span>
              {slab.grade}
            </div>

            <div className="mt-2 text-sm">
              Pop Total: {slab.population.total} • Higher:{" "}
              {slab.population.higher}
            </div>

            <div className="mt-2 text-sm text-gray-500">
              {slab.verified ? "Verified" : "Unverified"}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
