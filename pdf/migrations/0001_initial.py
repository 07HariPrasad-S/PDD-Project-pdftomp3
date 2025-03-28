# Generated by Django 5.1.5 on 2025-01-22 08:20

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="Profile",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "profile_pic",
                    models.ImageField(blank=True, upload_to="profile_pics"),
                ),
                ("name", models.CharField(max_length=225)),
                ("username", models.CharField(max_length=225)),
                ("passwords", models.CharField(max_length=225)),
                ("mobile_phone", models.CharField(default="xxxx", max_length=225)),
                ("email", models.EmailField(default="xxxx", max_length=225)),
                ("POSITION", models.CharField(default="xxxx", max_length=100)),
                (
                    "user",
                    models.OneToOneField(
                        on_delete=django.db.models.deletion.CASCADE,
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="PDFFile",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("pdf_file", models.FileField(upload_to="pdfs")),
                ("title", models.CharField(max_length=100)),
                ("date", models.DateTimeField(auto_now_add=True)),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="pdfs",
                        to="pdf.profile",
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="MP3File",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("mp3_file", models.FileField(upload_to="mp3s")),
                ("title", models.CharField(max_length=100)),
                ("date", models.DateTimeField(auto_now_add=True)),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="mp3s",
                        to="pdf.profile",
                    ),
                ),
            ],
        ),
    ]
