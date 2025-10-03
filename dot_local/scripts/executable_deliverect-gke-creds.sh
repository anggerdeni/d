#!/bin/sh
gcloud container clusters get-credentials dev --zone europe-west1-b --project deliverect-dev
gcloud container clusters get-credentials testing --zone europe-west1-b --project deliverect-testing
gcloud container clusters get-credentials staging --zone europe-west1-b --project deliverect-staging
gcloud container clusters get-credentials monitoring --zone europe-west1-b --project deliverect-staging
# gcloud container clusters get-credentials production --zone europe-west1-b --project deliverect-production
