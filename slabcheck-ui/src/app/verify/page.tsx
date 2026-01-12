"use client";

import { useState } from "react";
import { verifyCert } from "@/lib/api";

export default function VerifyPage() {
  const [cert, setCert] = useState("");
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<any>(null);
  const [error, setError] = useState("");

  async function handleVerify() {
    setError("");
    setLoading(true);
    setResult(null);

    const response = await verifyCert(cert);

    if (response.success) {
      setResult(response.slab);
    } else {
      setError("Could not verify this certificate.");
    }

    setLoading(false);
  }

  return (
    <div className="mt-20 p-6 space-y-6 max-w-md mx-auto">
      {/* Title */}
      <h1 className="text-2xl ml-35 font-bold text-gray-900 opacity-75 flex items-center justify-between">PSA Verifier</h1>

      {/* Input */}
      <input
        value={cert}
        onChange={(e) => setCert(e.target.value)}
        placeholder="Enter certificate number..."
        className="w-full shadow-lg rounded-lg p-3 bg-gray-200 text-gray-800 placeholder-gray-400 shadow-md"
      />

      {/* Verify button */}
      <button
        onClick={handleVerify}
        disabled={loading || cert.length === 0}
        className="w-full bg-blue-600 text-white py-3 rounded-lg shadow-md font-medium hover:bg-blue-700 opacity-80"
      >
        {loading ? "Verifying..." : "Verify"}
      </button>

      {/* Error */}
      {error && (
        <div className="text-red-600 font-medium text-center">{error}</div>
      )}

      {/* Result Card */}
      {result && (
        <div className="mt-6 p-5 rounded-xl shadow-lg bg-white">
          {/* Header */}
          <div className="flex items-center justify-between">
            <div className="font-bold text-lg text-gray-800">
              {result.grading_company}
            </div>

            <div className="flex items-center gap-2">
              {result.verified ? (
                <>
                  <span className="text-green-600 font-semibold">Verified</span>
                  <span>✔️</span>
                </>
              ) : (
                <>
                  <span className="text-red-600 font-semibold">Unverified</span>
                  <span>❌</span>
                </>
              )}
            </div>
          </div>

          {/* Card Name */}
          <div className="mt-4 font-semibold text-gray-800">
            {result.card_name}
          </div>

          <div className="mt-1 text-gray-500">Cert #{result.cert_number}</div>

          {/* Grade */}
          <div className="mt-4">
            <div className="text-sm text-gray-600">Grade</div>
            <div className="text-xl font-bold text-gray-900">
              {result.grade}
            </div>
          </div>

          {/* Population stats */}
          <div className="mt-4 grid grid-cols-3 gap-4 text-center">
            <div className="p-3 rounded-lg bg-gray-50">
              <div className="text-xs text-gray-600">Total Pop</div>
              <div className="font-bold text-gray-800">{result.population.total}</div>
            </div>

            <div className="p-3 rounded-lg bg-gray-50">
              <div className="text-xs text-gray-600">Higher</div>
              <div className="font-bold text-gray-800">{result.population.higher}</div>
            </div>

            <div className="p-3 rounded-lg bg-gray-50">
              <div className="text-xs text-gray-600">% of Grade</div>
              <div className="font-bold text-gray-800">
                {result.population.percentage ?? 0}%
              </div>
            </div>
          </div>

          {/* Timestamp */}
          <div className="mt-5 text-xs text-gray-400 text-right">
            Verified at: {new Date(result.scanned_at).toLocaleString()}
          </div>
        </div>
      )}
    </div>
  );
}
