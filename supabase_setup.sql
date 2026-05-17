-- ============================================================
--  COSOCKET — Supabase Database Setup
--  Run this ONCE in: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- 1. Create the bookings table
CREATE TABLE bookings (
  id            BIGSERIAL PRIMARY KEY,
  machine_name  TEXT NOT NULL,
  customer_name TEXT NOT NULL,
  whatsapp      TEXT NOT NULL,
  address       TEXT,
  start_date    DATE,
  duration      TEXT,
  notes         TEXT,
  status        TEXT DEFAULT 'new',   -- new | confirmed | completed | cancelled
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Allow the website to INSERT bookings (public, no login needed)
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public inserts"
  ON bookings FOR INSERT
  TO anon
  WITH CHECK (true);

-- 3. Only YOU (logged-in) can read/update bookings in the dashboard
CREATE POLICY "Allow authenticated reads"
  ON bookings FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow authenticated updates"
  ON bookings FOR UPDATE
  TO authenticated
  USING (true);

-- ============================================================
--  Done! Your bookings table is ready.
--  Every form submission from the website will appear here.
-- ============================================================
