# Generated by Django 3.1.5 on 2021-02-23 10:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('statistics', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='BadPoints',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('point_longitude', models.FloatField(verbose_name='Longitude of Point')),
                ('point_latitude', models.FloatField(verbose_name='Latitude of Point')),
                ('point_radius', models.FloatField(verbose_name='Radius of Point')),
                ('point_time', models.DateTimeField(verbose_name='Time of Point')),
            ],
        ),
        migrations.DeleteModel(
            name='BadPoint',
        ),
    ]