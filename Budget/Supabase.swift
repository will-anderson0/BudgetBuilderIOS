//
//  Supabase.swift
//  Budget
//
//  Created by Will Anderson on 3/24/24.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://ugtajrqwrsfowtqcbxje.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVndGFqcnF3cnNmb3d0cWNieGplIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEzMDc2ODIsImV4cCI6MjAyNjg4MzY4Mn0.vXNDthwBgxe50iPoSdw9f8WRSWgaNLpwuLU2eigz9HI"
)
