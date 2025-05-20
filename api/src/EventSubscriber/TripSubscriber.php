<?php

namespace App\EventSubscriber;

use ApiPlatform\Symfony\EventListener\EventPriorities;
use App\Entity\Trip;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpKernel\Event\ViewEvent;
use Symfony\Component\HttpKernel\KernelEvents;

final class TripSubscriber implements EventSubscriberInterface
{
    public function __construct(private Security $security)
    {
    }

    public static function getSubscribedEvents(): array
    {
        return [
            KernelEvents::VIEW  => ['addCurrentUserToNewTrip', EventPriorities::PRE_WRITE],
        ];
    }

    public function addCurrentUserToNewTrip(ViewEvent $event): void
    {
        $trip = $event->getControllerResult();
        $method = $event->getRequest()->getMethod();

        if (!$trip instanceof Trip || Request::METHOD_POST !== $method) {
            return;
        }

        $user = $this->security->getUser();
        
        $trip->addUser($user);
    }
}
