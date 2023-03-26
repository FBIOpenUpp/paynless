from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns

from . import views

urlpatterns = [
    # oauth
    path("oauth/", views.OAuthCreate.as_view(), name="oauth"),
    path("oauth/profile/", views.OAuthProfile.as_view(), name="oauth_profile"),
    # for business
    path(
        "oauth-business/",
        views.OAuthBusinessCreate.as_view(),
        name="oauth_business",
    ),
    path(
        "oauth-business/profile/",
        views.OAuthBusinessProfile.as_view(),
        name="oauth_business_profile",
    ),
]

urlpatterns = format_suffix_patterns(urlpatterns)
