import { Nav } from "@/components/nav";
import { SecondaryLink } from "@/components/primitives";

export default function NotFound() {
  return (
    <>
      <Nav />
      <main className="mx-auto flex min-h-[80vh] max-w-3xl flex-col items-start justify-center px-5">
        <p className="font-display text-mint">404</p>
        <h1 className="mt-3 font-display text-4xl font-bold">
          This page doesn&apos;t exist.
        </h1>
        <div className="mt-8">
          <SecondaryLink href="/">Back home</SecondaryLink>
        </div>
      </main>
    </>
  );
}
