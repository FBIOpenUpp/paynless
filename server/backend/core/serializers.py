from rest_framework.serializers import ModelSerializer

from .models import Role, User


class UserProfileSerializer(ModelSerializer):
    """
    Return user profile with posts and additional details.
    """

    class Meta:
        model = User
        extra_kwargs = {
            "id": {"required": True},
            "password": {"write_only": True},
        }
        fields = ("id", "role", "email", "name", "avatarUrl")

    def create(self, validated_data):
        user = User(
            id=validated_data["id"],
            email=validated_data["email"],
            name=validated_data["name"],
            avatarUrl=validated_data["avatarUrl"],
            username=validated_data["email"],
            role=validated_data.get("role", Role.USER.value),
        )
        user.set_password(validated_data["email"])
        user.save()
        return user


class BusinessProfileSerializer(ModelSerializer):
    """
    Return user profile with posts and additional details.
    """

    class Meta:
        model = User
        extra_kwargs = {
            "id": {"required": True},
            "password": {"write_only": True},
            "phone": {"required": True},
            "shopName": {"required": True},
            "shopAddress": {"required": True},
        }
        fields = (
            "id",
            "role",
            "email",
            "name",
            "avatarUrl",
            "phone",
            "shopName",
            "shopAddress",
        )

    def create(self, validated_data):
        user = User(
            id=validated_data["id"],
            email=validated_data["email"],
            name=validated_data["name"],
            avatarUrl=validated_data["avatarUrl"],
            username=validated_data["email"],
            role=validated_data.get("role", Role.USER.value),
            # business specific
            phone=validated_data.get("phone", ""),
            shopName=validated_data.get("shopName", ""),
            shopAddress=validated_data.get("shopAddress", ""),
        )
        user.set_password(validated_data["email"])
        user.save()
        return user
