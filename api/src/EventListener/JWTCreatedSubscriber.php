<?php

namespace App\EventListener;

use Lexik\Bundle\JWTAuthenticationBundle\Event\JWTCreatedEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class JWTCreatedSubscriber implements EventSubscriberInterface
{
    public static function getSubscribedEvents(): array
    {
        return [
            JWTCreatedEvent::class => 'onJWTCreated',
        ];
    }

    public function onJWTCreated(JWTCreatedEvent $event): void
    {
        dd('here');
        $user = $event->getUser();

        $payload = $event->getData();
        $payload['username'] = $user->getUserIdentifier(); // remplace par l'email
        $event->setData($payload);
    }
}
