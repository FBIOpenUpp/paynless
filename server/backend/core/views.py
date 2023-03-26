# Create your views here.
from rest_framework.generics import (
    CreateAPIView,
    RetrieveAPIView,
    RetrieveUpdateDestroyAPIView,
)
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.tokens import AccessToken
from rest_framework_simplejwt.views import Response

from .models import Role, User
from .permissions import IsSameUser
from .serializers import BusinessProfileSerializer, UserProfileSerializer


# OAuth views
class OAuthCreate(CreateAPIView):
    """
    Create the user from the oauth provider.
    post request:
     - id
     - email
     - name
     - avatar url
    """

    queryset = User.objects.all()
    serializer_class = UserProfileSerializer

    def perform_create(self, serializer):
        user = serializer.save()
        accessToken = AccessToken.for_user(user)
        return accessToken

    def create(self, request, *args, **kwargs):
        try:
            user = User.objects.get(email=request.data.get("email"))
        except Exception:
            user = None
        if user:
            accessToken = AccessToken.for_user(user)
            return Response(
                {"access_token": str(accessToken)},
                status=200,
            )
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        accessToken = self.perform_create(serializer)

        return Response(
            {"access_token": str(accessToken)},
            status=201,
        )


class OAuthProfile(RetrieveUpdateDestroyAPIView):
    """
    Retrieve, or modify a user's profile.
    """

    queryset = User.objects.all()
    permission_classes = [IsAuthenticated, IsSameUser]
    serializer_class = UserProfileSerializer

    def get_object(self):
        return self.request.user


class OAuthBusinessCreate(OAuthCreate):
    queryset = User.objects.filter(role=Role.BUSINESS.value)

    def get_serializer_class(self):
        return BusinessProfileSerializer


class OAuthBusinessProfile(RetrieveAPIView):
    queryset = User.objects.filter(role=Role.BUSINESS.value)
    permission_classes = [IsAuthenticated, IsSameUser]

    def get_serializer_class(self):
        return BusinessProfileSerializer

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(
            {
                "profile": serializer.data,
                "bank_details": {
                    "name": "Random Name",
                    "account_number": "1234567890",
                    "upi": "random@upi",
                    "total_amount": 3341141,
                    "payments": 120,
                },
            }
        )

    def get_object(self):
        return self.request.user
