<?php

namespace App\Controller;

use Symfony\Component\Security\Http\Attribute\CurrentUser;
use App\Entity\User;
use Lexik\Bundle\JWTAuthenticationBundle\Services\JWTTokenManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class ApiLoginController extends AbstractController
{
    #[Route('/api/login', name: 'api_login', methods: ['POST'])]
    public function index(#[CurrentUser] ?User $user, JWTTokenManagerInterface $JWTManager): JsonResponse
    {
        if (null === $user) {
                        return $this->json([
                             'message' => 'missing credentials',
                        ], Response::HTTP_UNAUTHORIZED);
                    }

        return new JsonResponse(['token' => $JWTManager->create($user)]);
    }
}
