# Generated by Django 3.1.5 on 2021-02-25 13:31

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='AbnormalRoadTemplate',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('round_log', models.JSONField(verbose_name='Record Log File')),
            ],
        ),
        migrations.CreateModel(
            name='NormalRoadTemplate',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('round_log', models.JSONField(verbose_name='Record Log File')),
            ],
        ),
    ]
