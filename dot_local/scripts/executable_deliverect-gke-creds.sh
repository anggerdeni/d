#!/bin/sh
gcloud container clusters get-credentials dev --zone europe-west1-b --project deliverect-dev
gcloud container clusters get-credentials testing --zone europe-west1-b --project deliverect-testing
gcloud container clusters get-credentials staging --zone europe-west1-b --project deliverect-staging
gcloud container clusters get-credentials monitoring --zone europe-west1-b --project deliverect-staging
gcloud container clusters get-credentials ypodomi-nonprod --region europe-west1 --project monitoring-nonprod-710788
gcloud container clusters get-credentials istio-test --region europe-west1 --project localtests-344116
# gcloud container clusters get-credentials production --zone europe-west1-b --project deliverect-production
