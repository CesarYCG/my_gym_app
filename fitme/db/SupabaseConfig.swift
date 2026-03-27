import Foundation
import Supabase

/// A global shared instance of the Supabase Client.
/// 
/// - IMPORTANT: Replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY` 
///   with your actual database credentials from your Supabase Project Settings.
let supabase = SupabaseClient(
    supabaseURL: URL(string: "YOUR_SUPABASE_URL")!,
    supabaseKey: "YOUR_SUPABASE_ANON_KEY"
)
