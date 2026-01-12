export const API_URL = process.env.NEXT_PUBLIC_API_URL;
console.log(">>> API_URL is:", API_URL);


export async function fetchSlabs() {
  const res = await fetch(`${API_URL}/slabs`);
  if (!res.ok) throw new Error("Failed to fetch slabs");
  return res.json();
}

export async function verifyCert(cert_number: string) {
  const res = await fetch(`${API_URL}/verify`, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `cert_number=${cert_number}`,
  });

  if (!res.ok) {
    return { success: false };
  }

  const data = await res.json();
  return { success: true, slab: data };
}

