import { Nav } from "@/components/nav";
import { Hero } from "@/components/hero";
import { About, Contact, Experience, Footer } from "@/components/sections";
import { SelectedWork } from "@/components/work";

export default function HomePage() {
  return (
    <>
      <Nav />
      <main>
        <Hero />
        <About />
        <SelectedWork />
        <Experience />
        <Contact />
      </main>
      <Footer />
    </>
  );
}
