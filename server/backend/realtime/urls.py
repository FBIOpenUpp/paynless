from django.urls import re_path

from . import consumers

urlpatterns = [
    re_path(r"ws/fetch/$", consumers.FetchNotification.as_asgi()),
    re_path(
        r"ws/put/$",
        consumers.UserConsumer.PutNotification.as_asgi(),
    ),
]
