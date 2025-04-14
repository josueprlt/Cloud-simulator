<?php
namespace App\Controller;

use App\Entity\User;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Doctrine\ORM\EntityManagerInterface;
use ErrorException;
use Lexik\Bundle\JWTAuthenticationBundle\Services\JWTTokenManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Exception\AuthenticationException;
use Symfony\Component\Validator\ConstraintViolationInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class AuthController extends AbstractController
{
    #[Route('api/register', name: 'api_register', methods: ['POST'])]
    public function register(Request $request, UserPasswordHasherInterface $passwordHasher, EntityManagerInterface $entityManager, ValidatorInterface $validator): JsonResponse
    {
        try {
            $data = json_decode($request->getContent(), true);
            $user = new User();
    
            $user->setUsername($data['username']);
            $user->setEmail($data['email']);
    
            if ($data['password'] === $data['confirmPassword']) {
    
                $plainPassword = $data['password'];
                $user->setPlainPassword($plainPassword);
                
                $errors = $validator->validate($user);

                if (count($errors) > 0) {
                    $errorMessages = [];
                    foreach ($errors as $error) {
                        if ($error instanceof ConstraintViolationInterface) {
                            $errorMessages[] = $error->getMessage();
                        }
                    }
    
                    return new JsonResponse(['error' => implode(', ', $errorMessages)], 400);
                }
    
                $hashed = $passwordHasher->hashPassword($user, $plainPassword);
                $user->setPassword($hashed);
            } else {
                return new JsonResponse(['error' => 'The passwords do not match'], 400);
            }
    
            $entityManager->persist($user);
            $entityManager->flush();
    
        } catch (UniqueConstraintViolationException $e) {
            return new JsonResponse(['error' => 'Email already exists.'], 400);
        } catch (ErrorException $e) {
            return new JsonResponse(['error' => sprintf('Something failed : ', $e)], 400);
        } 
    
        return new JsonResponse(['message' => sprintf('Success, User: %s has been created.', $data['email'])], 201);
    }
}
