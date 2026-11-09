import type { Metadata } from "next";

/** Contact address shown in both language sections. */
const CONTACT = "omarxioa@gmail.com";

const UPDATED = "9 نوفمبر 2026";
const UPDATED_EN = "November 9, 2026";

/*
 * Privacy policy for the Muslim Assistant app (linked from the app stores).
 * Intentionally unlisted: noindex, not in the nav, footer, home page or
 * sitemap. Reachable only at /muslim-assistant/privacy/. Rendered without the
 * site nav and footer so it has no links into the rest of the portfolio.
 */
export const metadata: Metadata = {
  title: { absolute: "سياسة الخصوصية — مساعد المسلم" },
  robots: { index: false, follow: false },
  alternates: { canonical: "/muslim-assistant/privacy/" },
};

export default function PrivacyPage() {
  return (
    <main className="mx-auto max-w-3xl px-5 py-16 sm:py-20">
      <div className="prose-dark policy">
        <section dir="rtl" lang="ar">
          <h1>سياسة الخصوصية — مساعد المسلم</h1>
          <p>آخر تحديث: {UPDATED}</p>

          <p>
            تطبيق «مساعد المسلم» مصمم ليعمل بالكامل على جهازك. لا يُنشئ التطبيق
            حسابًا، ولا يطلب تسجيل دخول، ولا يرسل بياناتك إلى أي خادم، ولا يحتوي
            على إعلانات أو أدوات تتبع.
          </p>

          <h2>البيانات التي يستخدمها التطبيق</h2>
          <ul>
            <li>
              <strong>الموقع الجغرافي:</strong> يُستخدم لحساب مواقيت الصلاة
              واتجاه القبلة. يُطلب الإذن «أثناء استخدام التطبيق» فقط، ولا يعمل
              التطبيق في الخلفية لتتبع موقعك. تُحفظ إحداثيات مدينتك على جهازك
              فقط. ويمكنك بدلًا من ذلك اختيار مدينتك يدويًا دون منح إذن الموقع.
            </li>
            <li>
              <strong>سجل الصلوات والتسبيح والأذكار:</strong> يُحفظ على جهازك
              فقط، ولا يغادره.
            </li>
            <li>
              <strong>الإعدادات:</strong> مثل طريقة الحساب واللغة والمظهر، تُحفظ
              على جهازك فقط.
            </li>
          </ul>

          <h2>الإشعارات</h2>
          <p>
            تنبيهات الأذان والتذكيرات إشعارات محلية يُنشئها جهازك بنفسه من
            المواقيت المحسوبة عليه. لا تمر بأي خادم.
          </p>

          <h2>الاتصال بالإنترنت</h2>
          <p>
            يعمل التطبيق دون إنترنت. يُستخدم الاتصال فقط عند البحث عن اسم مدينة
            أو تحويل إحداثياتك إلى اسم مدينة، عبر خدمة الموقع المدمجة في نظام
            التشغيل (Apple أو Google)، وتخضع تلك الخدمة لسياسة خصوصية النظام.
          </p>

          <h2>الأدوات (الويدجت)</h2>
          <p>
            تقرأ أدوات الشاشة الرئيسية وشاشة القفل البيانات من مساحة مشتركة على
            جهازك خاصة بالتطبيق. لا تجمع شيئًا ولا ترسل شيئًا.
          </p>

          <h2>حذف البيانات</h2>
          <p>
            يمكنك حذف كل بياناتك من داخل التطبيق عبر «الإعدادات ← مسح البيانات»،
            أو بحذف التطبيق من جهازك.
          </p>

          <h2>الأطفال</h2>
          <p>
            لا يجمع التطبيق أي بيانات شخصية من أي مستخدم، بما في ذلك الأطفال.
          </p>

          <h2>التغييرات</h2>
          <p>
            إذا أُضيفت ميزات تتطلب اتصالًا بخادم مستقبلًا (مثل إشعارات
            المناسبات)، ستُحدَّث هذه الصفحة قبل إتاحتها، وسيُذكر بوضوح ما يُرسل.
          </p>

          <h2>التواصل</h2>
          <p>
            لأي سؤال عن الخصوصية: <a href={`mailto:${CONTACT}`}>{CONTACT}</a>
          </p>
        </section>

        <hr className="my-14 border-white/10" />

        <section dir="ltr" lang="en">
          <h1>Privacy Policy — Muslim Assistant</h1>
          <p>Last updated: {UPDATED_EN}</p>

          <p>
            Muslim Assistant is designed to work entirely on your device. The app
            has no accounts, no sign-in, sends no data to any server, and
            contains no ads or tracking.
          </p>

          <h2>Data the app uses</h2>
          <ul>
            <li>
              <strong>Location:</strong> used to calculate prayer times and the
              Qibla direction. Permission is requested &ldquo;While Using the
              App&rdquo; only; the app never tracks your location in the
              background. Your city&rsquo;s coordinates are stored on your
              device only. You can also pick your city manually without granting
              location access.
            </li>
            <li>
              <strong>Prayer log, tasbih, and adhkar progress:</strong> stored
              on your device only and never leave it.
            </li>
            <li>
              <strong>Settings:</strong> such as calculation method, language,
              and appearance, stored on your device only.
            </li>
          </ul>

          <h2>Notifications</h2>
          <p>
            Adhan alerts and reminders are local notifications scheduled by your
            device from the times it calculates. They do not pass through any
            server.
          </p>

          <h2>Internet access</h2>
          <p>
            The app works offline. Internet is used only when searching for a
            city name or converting your coordinates to a city name, through the
            operating system&rsquo;s built-in geocoding service (Apple or
            Google), which is governed by that system&rsquo;s privacy policy.
          </p>

          <h2>Widgets</h2>
          <p>
            Home screen and lock screen widgets read their data from an
            app-private shared container on your device. They collect nothing
            and send nothing.
          </p>

          <h2>Deleting your data</h2>
          <p>
            You can delete all your data from within the app via Settings →
            Clear data, or by deleting the app from your device.
          </p>

          <h2>Children</h2>
          <p>
            The app does not collect personal data from any user, including
            children.
          </p>

          <h2>Changes</h2>
          <p>
            If features that require a server are added in the future (such as
            occasion notifications), this page will be updated before they are
            released, and what is sent will be stated clearly.
          </p>

          <h2>Contact</h2>
          <p>
            For privacy questions: <a href={`mailto:${CONTACT}`}>{CONTACT}</a>
          </p>
        </section>
      </div>
    </main>
  );
}
