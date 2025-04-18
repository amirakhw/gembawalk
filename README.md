# Attijari Gemba Walk

## Overview

Attijari Gemba Walk is a mobile application designed to digitize and streamline the process of conducting "Gemba Walks" (on-site observation visits) at Attijari Bank agencies in Tunisia. The application enables inspectors to document anomalies during visits, notifies technical teams for resolution, tracks progress, and generates analytical reports. This document provides a high-level overview of the project.

## Features

### Core Features (MVP)

* **User Authentication:** Secure login system with role-based access control
* **Visit Management:** Digital checklists for agency inspections
* **Anomaly Documentation:** Capture issues with photos and comments
* **Notification System:** Alert technicians of new anomalies
* **Resolution Tracking:** Monitor progress and confirm resolution
* **Dashboard & Reporting:** Analytics on visit data and anomaly resolution

### User Roles

* **Visitor:** Conducts inspections and completes checklists
* **Technician (Logistics/IT):** Receives and resolves reported anomalies
* **Managers/Directors:** Access dashboard for monitoring

### Tech Stack

* **Backend:** Spring Boot (Java)
* **Frontend:** Flutter (Dart)
* **Database:** MySQL (Development), Oracle (Production)

## Getting Started (For Developers)

1.  Navigate to the `gembawalk_back` directory for backend setup instructions.
2.  Navigate to the `gembawalk_front` directory for frontend setup instructions.

## Branching Strategy

We use feature branches for all new development. Create a new branch from `main` for each feature or bug fix.
