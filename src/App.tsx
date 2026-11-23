import { useState, useEffect } from 'react';
import { NeuroCallLanding } from './components/NeuroCallLanding';
import { NeuroCallPrivacy } from './components/NeuroCallPrivacy';
import { NeuroCallSupport } from './components/NeuroCallSupport';

export default function App() {
  const [currentPath, setCurrentPath] = useState<string>(() => {
    if (typeof window !== 'undefined') {
      const p = window.location.pathname.toLowerCase();
      if (p.includes('/privacy')) return '/privacy';
      if (p.includes('/support')) return '/support';
    }
    return '/';
  });

  useEffect(() => {
    const handlePopState = () => {
      const p = window.location.pathname.toLowerCase();
      if (p.includes('/privacy')) setCurrentPath('/privacy');
      else if (p.includes('/support')) setCurrentPath('/support');
      else setCurrentPath('/');
    };
    window.addEventListener('popstate', handlePopState);
    return () => window.removeEventListener('popstate', handlePopState);
  }, []);

  const handleNavigate = (path: string) => {
    if (typeof window !== 'undefined') {
      window.history.pushState({}, '', path);
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }
    setCurrentPath(path);
  };

  if (currentPath === '/privacy') {
    return <NeuroCallPrivacy onNavigate={handleNavigate} />;
  }

  if (currentPath === '/support') {
    return <NeuroCallSupport onNavigate={handleNavigate} />;
  }

  return <NeuroCallLanding onNavigate={handleNavigate} />;
}
