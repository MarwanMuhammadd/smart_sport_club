/// This file contains the static knowledge base of the Smart Sports Club.
/// It is injected into the Gemini prompt so the AI answers ONLY from real data.
library;

const String appData = """
=== SMART SPORTS CLUB — INTERNAL DATA ===

--- ACADEMIES ---
1. Tennis Academy
2. Swimming Academy
3. Football Academy

--- COACHES ---
- Mike   (ID: 1) — Tennis Academy
- Sarah  (ID: 2) — Swimming Academy
- Jordan (ID: 3) — Football Academy
- Alex   (ID: 4) — Tennis Academy

--- SESSIONS ---
Sessions are available daily starting from 09:00 AM.
Each session lasts 1 hour. Example slots:
  - Session 1: 09:00 AM – 10:00 AM
  - Session 2: 10:00 AM – 11:00 AM
  - Session 3: 11:00 AM – 12:00 PM
Each session has a maximum capacity of 20 members.

--- BOOKING ---
Members can book a session by selecting an academy, choosing a coach, picking a date, and selecting an available slot.
A slot is full when currentBookings = maxCapacity (20).

--- SERVICES ---
The club offers the following services:
  - Club Restaurant
  - Upcoming Parties
  - Café
  - Kids Activities

--- ANNOUNCEMENTS / BANNERS ---
- New Tennis Courts Open! — Book your slot now for the weekend tournament.
- Swimming Pool Renovated — Enjoy the new Olympic size pool.
- Gym Membership Offer — Get 30% off this month.

--- SUPPORT ---
Hotline: 01012345678
Working hours: Saturday to Thursday, 9:00 AM – 6:00 PM.
For app issues, contact support through the Help section.

=== END OF DATA ===
""";

/// Builds the full structured prompt to send to Gemini.
String buildPrompt(String userMessage) {
  return """
You are a Smart Sports Club Assistant.

Rules:
- Answer ONLY using the data provided below.
- Do NOT make up any information (no fake phone numbers, fake coaches, fake sessions).
- Do NOT repeat generic phrases like "I am here to help with sessions...".
- Keep answers short, direct, and natural.
- If the answer is not in the data below, respond with exactly: "I couldn't find that information."

$appData

User Question: $userMessage
""";
}
