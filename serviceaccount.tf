resource "google_service_account" "service-account" {
  account_id   = "iti-mariam-sa-1"
  display_name = "iti-mariam-sa-1"
}

resource "google_project_iam_binding" "service-binding" {
  role    = "roles/container.admin"
 
  project = "iti-mariam"
  members = [
    "serviceAccount:${google_service_account.service-account.email}"
  ]
}

resource "google_project_iam_binding" "service-binding1" {
  role    = "roles/storage.objectViewer"
 
  project = "iti-mariam"
  members = [
    "serviceAccount:${google_service_account.service-account.email}"
  ]
}