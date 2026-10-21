import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const ink = Color(0xFF17243B);
const muted = Color(0xFF738096);
const canvas = Color(0xFFF4F6FA);
const lime = Color(0xFFC9F36A);
const green = Color(0xFF267B5C);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    const [DeviceOrientation.portraitUp],
  );

  runApp(const MooveApp());
}

class MooveApp extends StatelessWidget {
  const MooveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOOVE รถเช่า',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: canvas,
        colorScheme: ColorScheme.fromSeed(seedColor: ink).copyWith(
          primary: ink,
          secondary: lime,
          surface: Colors.white,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(color: ink, fontWeight: FontWeight.w800, letterSpacing: -.4),
          titleLarge: TextStyle(color: ink, fontWeight: FontWeight.w800),
          titleMedium: TextStyle(color: ink, fontWeight: FontWeight.w700),
          bodyMedium: TextStyle(color: ink),
          bodySmall: TextStyle(color: muted),
        ),
      ),
      home: const LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeShell()),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: ink,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(Icons.route_rounded, color: lime, size: 42),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'MOOVE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ink,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'รถพร้อมไปทุกทริป',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted, fontSize: 13),
                  ),
                  const SizedBox(height: 34),
                  const Text(
                    'ยินดีต้อนรับกลับ 👋',
                    style: TextStyle(color: ink, fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'เข้าสู่ระบบเพื่อค้นหาและจองรถคันโปรดของคุณ',
                    style: TextStyle(color: muted, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 25),
                  const Text('อีเมล', style: TextStyle(color: ink, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'name@example.com',
                      prefixIcon: const Icon(Icons.mail_outline_rounded),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE5E9F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE5E9F0)),
                      ),
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
                        return 'กรุณากรอกอีเมลให้ถูกต้อง';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  const Text('รหัสผ่าน', style: TextStyle(color: ink, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _hidePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _login(),
                    decoration: InputDecoration(
                      hintText: 'กรอกรหัสผ่านอย่างน้อย 6 ตัว',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _hidePassword = !_hidePassword),
                        icon: Icon(_hidePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE5E9F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE5E9F0)),
                      ),
                    ),
                    validator: (value) {
                      if ((value ?? '').length < 6) return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        activeColor: ink,
                        onChanged: (value) => setState(() => _rememberMe = value ?? false),
                      ),
                      const Text('จดจำฉันไว้', style: TextStyle(color: muted, fontSize: 12)),
                      const Spacer(),
                      TextButton(
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ระบบตัวอย่าง: กรุณาติดต่อผู้ดูแลเพื่อรีเซ็ตรหัสผ่าน')),
                        ),
                        child: const Text('ลืมรหัสผ่าน?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed: _login,
                      style: FilledButton.styleFrom(
                        backgroundColor: ink,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Color(0xFFE0E5EC))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('หรือ', style: TextStyle(color: muted, fontSize: 12)),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE0E5EC))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: _login,
                    icon: const Icon(Icons.person_outline_rounded),
                    label: const Text('ทดลองเข้าใช้งาน'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ink,
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(color: Color(0xFFDCE2EA)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'MOOVE • แอปต้นแบบสำหรับการเรียน',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class Car {
  const Car({
    required this.id,
    required this.name,
    required this.kind,
    required this.price,
    required this.color,
    required this.icon,
    required this.seats,
    required this.gear,
    required this.fuel,
    required this.rating,
    required this.tag,
  });

  final String id;
  final String name;
  final String kind;
  final int price;
  final Color color;
  final IconData icon;
  final int seats;
  final String gear;
  final String fuel;
  final String rating;
  final String tag;
}

const cars = <Car>[
  Car(id: 'yaris', name: 'Toyota Yaris Ativ', kind: 'อีโคคาร์ • ซีดาน', price: 1290, color: Color(0xFFD9E5ED), icon: Icons.directions_car_filled, seats: 5, gear: 'อัตโนมัติ', fuel: 'เบนซิน', rating: '4.9', tag: 'คุ้มค่า'),
  Car(id: 'city', name: 'Honda City Hatchback', kind: 'คอมแพกต์ • แฮตช์แบ็ก', price: 1590, color: Color(0xFFDCE6D8), icon: Icons.directions_car_filled, seats: 5, gear: 'อัตโนมัติ', fuel: 'เบนซิน', rating: '4.8', tag: 'ยอดนิยม'),
  Car(id: 'dolphin', name: 'BYD Dolphin', kind: 'รถไฟฟ้า • แฮตช์แบ็ก', price: 1890, color: Color(0xFFDDE2F4), icon: Icons.electric_car, seats: 5, gear: 'อัตโนมัติ', fuel: 'ไฟฟ้า', rating: '4.9', tag: 'รถไฟฟ้า'),
  Car(id: 'mazda', name: 'Mazda 2 Skyactiv', kind: 'อีโคคาร์ • ซีดาน', price: 1390, color: Color(0xFFF0E2D7), icon: Icons.directions_car_filled, seats: 5, gear: 'อัตโนมัติ', fuel: 'ดีเซล', rating: '4.7', tag: 'ขับสนุก'),
];

class FavoriteStore {
  static final ids = ValueNotifier<Set<String>>(<String>{});
  static bool contains(String id) => ids.value.contains(id);
  static void toggle(String id) => ids.value = {...ids.value}..toggle(id);
}

extension _SetToggle<T> on Set<T> {
  void toggle(T value) => contains(value) ? remove(value) : add(value);
}

class BookingStore {
  static final items = ValueNotifier<List<Car>>(<Car>[]);
  static void add(Car car) => items.value = [car, ...items.value];
}

void pushPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  // Shared tab selection so the success page can open the bookings tab.
  static final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  void showCar(Car car) => pushPage(context, CarDetailPage(car: car));

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomePage(onSearch: () => pushPage(context, const SearchPage()), onCarTap: showCar),
      SavedPage(onCarTap: showCar),
      const TripsPage(),
      const ProfilePage(),
    ];
    return ValueListenableBuilder<int>(
      valueListenable: HomeShell.selectedTab,
      builder: (context, selected, _) => Scaffold(
        body: IndexedStack(index: selected, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selected,
          onDestinationSelected: (index) => HomeShell.selectedTab.value = index,
          backgroundColor: Colors.white,
          indicatorColor: lime.withOpacity(.48),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'หน้าแรก'),
            NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'บันทึก'),
            NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'การจอง'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'โปรไฟล์'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({required this.onSearch, required this.onCarTap, super.key});
  final VoidCallback onSearch;
  final ValueChanged<Car> onCarTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(15)), child: const Icon(Icons.route_rounded, color: lime)),
            const SizedBox(width: 11),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('MOOVE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.5, fontSize: 17, color: ink)), Text('รถพร้อมไปทุกทริป', style: TextStyle(color: muted, fontSize: 11))]),
            const Spacer(),
            IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded), style: IconButton.styleFrom(backgroundColor: Colors.white)),
          ]),
          const SizedBox(height: 24),
          const Text('สวัสดี, นักเดินทาง 👋', style: TextStyle(color: muted, fontSize: 14)),
          const SizedBox(height: 5),
          const Text('วันนี้อยากไปไหน?', style: TextStyle(color: ink, fontSize: 25, fontWeight: FontWeight.w800)),
          const SizedBox(height: 17),
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onSearch,
            child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8ECF2))), child: const Row(children: [Icon(Icons.search_rounded, color: muted), SizedBox(width: 11), Expanded(child: Text('ค้นหารุ่นรถ หรือสถานที่รับรถ', style: TextStyle(color: muted))), Icon(Icons.tune_rounded, color: ink)])),
          ),
          const SizedBox(height: 20),
          Container(
            height: 174,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: const LinearGradient(colors: [ink, Color(0xFF314667)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Stack(children: [
              Positioned(right: -15, bottom: -28, child: Icon(Icons.directions_car_filled_rounded, size: 190, color: Colors.white.withOpacity(.12))),
              Positioned(right: 25, top: 20, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: lime, borderRadius: BorderRadius.circular(20)), child: const Text('ขับเลย จ่ายทีหลัง', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 10, color: ink)))),
              const Positioned(left: 20, top: 25, child: Text('ออกทริปได้ง่าย\nเริ่มต้น 1,290 บาท', style: TextStyle(color: Colors.white, fontSize: 22, height: 1.35, fontWeight: FontWeight.w800))),
              Positioned(left: 20, bottom: 17, child: TextButton.icon(onPressed: onSearch, icon: const Icon(Icons.arrow_forward, size: 16), label: const Text('เลือกรถเลย'), style: TextButton.styleFrom(backgroundColor: Colors.white, foregroundColor: ink, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9), textStyle: const TextStyle(fontWeight: FontWeight.w800)))),
            ]),
          ),
          const SizedBox(height: 25),
          Row(children: [const Expanded(child: Text('รถแนะนำสำหรับคุณ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink))), TextButton(onPressed: onSearch, child: const Text('ดูทั้งหมด  →'))]),
          const SizedBox(height: 7),
          ...cars.take(3).map((car) => Padding(padding: const EdgeInsets.only(bottom: 12), child: CarCard(car: car, onTap: () => onCarTap(car)))),
          const SizedBox(height: 4),
          const Row(children: [Icon(Icons.verified_user_outlined, size: 16, color: green), SizedBox(width: 7), Text('รถทุกคันผ่านการตรวจเช็กก่อนส่งมอบ', style: TextStyle(color: muted, fontSize: 11))]),
        ]),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  String category = 'ทั้งหมด';
  final categories = const ['ทั้งหมด', 'อีโคคาร์', 'รถไฟฟ้า', 'ซีดาน'];

  @override
  Widget build(BuildContext context) {
    final filtered = cars.where((car) {
      final matchesText = car.name.toLowerCase().contains(query.toLowerCase());
      final matchesCategory = category == 'ทั้งหมด' || car.kind.contains(category) || (category == 'ซีดาน' && car.kind.contains('ซีดาน'));
      return matchesText && matchesCategory;
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('ค้นหารถ'), backgroundColor: canvas),
      body: ListView(padding: const EdgeInsets.fromLTRB(20, 6, 20, 24), children: [
        TextField(onChanged: (value) => setState(() => query = value), decoration: InputDecoration(hintText: 'พิมพ์ชื่อรุ่นรถ', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none))),
        const SizedBox(height: 18),
        const Text('ประเภทรถ', style: TextStyle(fontWeight: FontWeight.w800, color: ink)),
        const SizedBox(height: 9),
        Wrap(spacing: 8, children: categories.map((item) => ChoiceChip(label: Text(item), selected: category == item, onSelected: (_) => setState(() => category = item), selectedColor: lime, backgroundColor: Colors.white)).toList()),
        const SizedBox(height: 18),
        Text('พบรถ ${filtered.length} คัน', style: const TextStyle(color: muted, fontSize: 13)),
        const SizedBox(height: 10),
        if (filtered.isEmpty) const EmptyState(icon: Icons.search_off, title: 'ไม่พบรถที่ค้นหา', subtitle: 'ลองค้นหาด้วยชื่อรุ่นอื่น'),
        ...filtered.map((car) => Padding(padding: const EdgeInsets.only(bottom: 12), child: CarCard(car: car, onTap: () => pushPage(context, CarDetailPage(car: car))))),
      ]),
    );
  }
}

class SavedPage extends StatelessWidget {
  const SavedPage({required this.onCarTap, super.key});
  final ValueChanged<Car> onCarTap;

  @override
  Widget build(BuildContext context) => SafeArea(child: ValueListenableBuilder<Set<String>>(
    valueListenable: FavoriteStore.ids,
    builder: (context, ids, _) {
      final saved = cars.where((car) => ids.contains(car.id)).toList();
      return ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 24), children: [
        const Text('รถที่บันทึกไว้', style: TextStyle(color: ink, fontSize: 24, fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text('${saved.length} คันในรายการโปรด', style: const TextStyle(color: muted)),
        const SizedBox(height: 18),
        if (saved.isEmpty) const EmptyState(icon: Icons.favorite_border, title: 'ยังไม่มีรถที่บันทึก', subtitle: 'กดหัวใจบนรถที่ชอบ แล้วกลับมาดูได้ที่นี่'),
        ...saved.map((car) => Padding(padding: const EdgeInsets.only(bottom: 12), child: CarCard(car: car, onTap: () => onCarTap(car)))),
      ]);
    },
  ));
}

class CarDetailPage extends StatelessWidget {
  const CarDetailPage({required this.car, super.key});
  final Car car;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('รายละเอียดรถ'), backgroundColor: canvas, actions: [ValueListenableBuilder<Set<String>>(valueListenable: FavoriteStore.ids, builder: (context, ids, _) => IconButton(onPressed: () => FavoriteStore.toggle(car.id), icon: Icon(ids.contains(car.id) ? Icons.favorite : Icons.favorite_border, color: ids.contains(car.id) ? Colors.redAccent : ink)))]),
    body: ListView(padding: const EdgeInsets.fromLTRB(20, 4, 20, 28), children: [
      CarArtwork(car: car, height: 220, rounded: 26),
      const SizedBox(height: 18),
      Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(car.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: ink)), const SizedBox(height: 4), Text(car.kind, style: const TextStyle(color: muted))])), const Icon(Icons.star_rounded, color: Color(0xFFFFB547)), const SizedBox(width: 4), Text(car.rating, style: const TextStyle(fontWeight: FontWeight.w800, color: ink))]),
      const SizedBox(height: 20),
      Row(children: [SpecPill(icon: Icons.event_seat_outlined, label: '${car.seats} ที่นั่ง'), SpecPill(icon: Icons.settings_outlined, label: car.gear), SpecPill(icon: Icons.local_gas_station_outlined, label: car.fuel)]),
      const SizedBox(height: 22),
      const Text('เกี่ยวกับรถคันนี้', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 8),
      const Text('รถสะอาดพร้อมใช้งาน เหมาะทั้งเดินทางในเมืองและออกทริปต่างจังหวัด รับรถง่าย มีประกันพื้นฐานตามเงื่อนไขของผู้ให้บริการ', style: TextStyle(height: 1.6, color: muted)),
      const SizedBox(height: 18),
      const DetailBullet(icon: Icons.check_circle_outline, text: 'ระยะทาง 300 กม. ต่อวัน'),
      const DetailBullet(icon: Icons.check_circle_outline, text: 'ยกเลิกฟรีก่อนรับรถ 24 ชั่วโมง'),
      const DetailBullet(icon: Icons.check_circle_outline, text: 'รับรถได้ที่สถานีรถไฟฟ้าอโศก'),
      const SizedBox(height: 22),
      Row(children: [Expanded(child: PriceLabel(price: car.price)), const SizedBox(width: 12), FilledButton(onPressed: () => pushPage(context, BookingPage(car: car)), style: FilledButton.styleFrom(backgroundColor: ink, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)), child: const Text('จองรถ'))]),
    ]),
  );
}

class BookingPage extends StatefulWidget {
  const BookingPage({required this.car, super.key});
  final Car car;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late DateTime pickup;
  late DateTime dropoff;
  String location = 'อโศก, กรุงเทพฯ';

  @override
  void initState() {
    super.initState();
    pickup = DateTime.now().add(const Duration(days: 2));
    dropoff = DateTime.now().add(const Duration(days: 4));
  }

  int get days => dropoff.difference(pickup).inDays.clamp(1, 30).toInt();
  String dateLabel(DateTime date) => '${date.day} ${thaiMonths[date.month - 1]} ${date.year + 543}';

  Future<void> chooseDate(bool isPickup) async {
    final date = await showDatePicker(context: context, initialDate: isPickup ? pickup : dropoff, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
    if (date == null || !mounted) return;
    setState(() {
      if (isPickup) {
        pickup = date;
        if (!dropoff.isAfter(pickup)) dropoff = pickup.add(const Duration(days: 1));
      } else {
        dropoff = date.isAfter(pickup) ? date : pickup.add(const Duration(days: 1));
      }
    });
  }

  Future<void> chooseLocation() async {
    final choice = await showModalBottomSheet<String>(context: context, backgroundColor: Colors.white, builder: (context) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: ['อโศก, กรุงเทพฯ', 'สนามบินสุวรรณภูมิ', 'สถานีกลางกรุงเทพอภิวัฒน์'].map((place) => ListTile(leading: const Icon(Icons.location_on_outlined, color: ink), title: Text(place), onTap: () => Navigator.pop(context, place))).toList())));
    if (choice != null) setState(() => location = choice);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ข้อมูลการจอง'), backgroundColor: canvas),
    body: ListView(padding: const EdgeInsets.fromLTRB(20, 4, 20, 26), children: [
      CarCard(car: widget.car, onTap: () {}),
      const SizedBox(height: 20),
      const Text('กำหนดวันเดินทาง', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 10),
      DateTile(label: 'วันรับรถ', date: dateLabel(pickup), onTap: () => chooseDate(true)),
      const SizedBox(height: 10),
      DateTile(label: 'วันคืนรถ', date: dateLabel(dropoff), onTap: () => chooseDate(false)),
      const SizedBox(height: 18),
      const Text('จุดรับรถ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 9),
      InkWell(onTap: chooseLocation, borderRadius: BorderRadius.circular(16), child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [const Icon(Icons.location_on_outlined, color: green), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('สถานที่รับรถ', style: TextStyle(color: muted, fontSize: 11)), Text(location, style: const TextStyle(color: ink, fontWeight: FontWeight.w700))])), const Icon(Icons.keyboard_arrow_down, color: muted)]))),
      const SizedBox(height: 18),
      SummaryRow(label: 'ค่าเช่า $days วัน', value: '฿${(widget.car.price * days).toString()}'),
      const SummaryRow(label: 'ค่าบริการ', value: '฿100'),
      const Divider(height: 24),
      SummaryRow(label: 'ยอดรวมโดยประมาณ', value: '฿${(widget.car.price * days + 100).toString()}', strong: true),
      const SizedBox(height: 18),
      FilledButton(onPressed: () => pushPage(context, PaymentPage(car: widget.car, days: days)), style: FilledButton.styleFrom(backgroundColor: ink, padding: const EdgeInsets.symmetric(vertical: 16)), child: const Text('ดำเนินการต่อ')),
    ]),
  );
}

const thaiMonths = ['ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'];

class PaymentPage extends StatefulWidget {
  const PaymentPage({required this.car, required this.days, super.key});
  final Car car;
  final int days;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selected = 0;
  final methods = const [
    (Icons.credit_card_rounded, 'บัตรเครดิต / เดบิต', 'Visa, Mastercard'),
    (Icons.account_balance_rounded, 'โมบายแบงก์กิง', 'สแกน QR พร้อมเพย์'),
    (Icons.payments_outlined, 'ชำระเมื่อรับรถ', 'เงินสดหรือโอนให้ผู้ให้บริการ'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ชำระเงิน'), backgroundColor: canvas),
    body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 26), children: [
      const Text('เลือกช่องทางชำระเงิน', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: ink)),
      const SizedBox(height: 7),
      const Text('เลือกวิธีที่สะดวกสำหรับคุณ', style: TextStyle(color: muted)),
      const SizedBox(height: 17),
      ...List.generate(methods.length, (index) {
        final method = methods[index];
        return Padding(padding: const EdgeInsets.only(bottom: 10), child: InkWell(onTap: () => setState(() => selected = index), borderRadius: BorderRadius.circular(17), child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: selected == index ? ink : const Color(0xFFE8ECF2), width: selected == index ? 1.5 : 1)), child: Row(children: [Icon(method.$1, color: ink), const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(method.$2, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)), Text(method.$3, style: const TextStyle(color: muted, fontSize: 12))])), Icon(selected == index ? Icons.radio_button_checked : Icons.radio_button_off, color: selected == index ? green : muted)]))));
      }),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Column(children: [SummaryRow(label: 'รถ ${widget.car.name}', value: '${widget.days} วัน'), SummaryRow(label: 'ค่าบริการ', value: '฿100'), const Divider(height: 22), SummaryRow(label: 'ยอดชำระ', value: '฿${(widget.car.price * widget.days + 100).toString()}', strong: true)])),
      const SizedBox(height: 18),
      const Row(children: [Icon(Icons.lock_outline, size: 16, color: green), SizedBox(width: 7), Text('ข้อมูลจำลองสำหรับการนำเสนอโปรเจกต์', style: TextStyle(fontSize: 11, color: muted))]),
      const SizedBox(height: 15),
      FilledButton(
        onPressed: () {
          BookingStore.add(widget.car);
          pushPage(context, SuccessPage(car: widget.car, days: widget.days));
        },
        style: FilledButton.styleFrom(backgroundColor: ink, padding: const EdgeInsets.symmetric(vertical: 16)),
        child: const Text('ยืนยันการจอง'),
      ),
    ]),
  );
}

class SuccessPage extends StatefulWidget {
  const SuccessPage({required this.car, required this.days, super.key});
  final Car car;
  final int days;
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) => Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(width: 104, height: 104, decoration: const BoxDecoration(color: Color(0xFFE4F5EC), shape: BoxShape.circle), child: const Icon(Icons.check_rounded, size: 58, color: green)),
    const SizedBox(height: 24),
    const Text('จองรถสำเร็จ!', style: TextStyle(color: ink, fontWeight: FontWeight.w900, fontSize: 27)),
    const SizedBox(height: 8),
    const Text('พร้อมออกเดินทางแล้ว\nรายละเอียดการจองถูกเพิ่มไว้ในรายการของคุณ', textAlign: TextAlign.center, style: TextStyle(color: muted, height: 1.5)),
    const SizedBox(height: 22),
    Container(width: double.infinity, padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.car.name, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)), const SizedBox(height: 7), Text('${widget.days} วัน • หมายเลขจอง MV-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}', style: const TextStyle(color: muted, fontSize: 12)), const SizedBox(height: 13), SummaryRow(label: 'ยอดชำระ', value: '฿${(widget.car.price * widget.days + 100).toString()}', strong: true)])),
    const SizedBox(height: 25),
    SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          HomeShell.selectedTab.value = 2;
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        style: FilledButton.styleFrom(backgroundColor: ink, padding: const EdgeInsets.symmetric(vertical: 16)),
        child: const Text('ดูรายการจอง'),
      ),
    ),
  ]))));
}

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(child: ValueListenableBuilder<List<Car>>(
    valueListenable: BookingStore.items,
    builder: (context, bookings, _) => ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 24), children: [
      const Text('การจองของฉัน', style: TextStyle(color: ink, fontSize: 24, fontWeight: FontWeight.w800)),
      const SizedBox(height: 5),
      const Text('จัดการทริปและดูรายละเอียดรถ', style: TextStyle(color: muted)),
      const SizedBox(height: 18),
      if (bookings.isEmpty) const EmptyState(icon: Icons.luggage_outlined, title: 'ยังไม่มีรายการจอง', subtitle: 'เลือกรถที่ใช่ แล้วเริ่มวางแผนทริปแรกของคุณ'),
      ...bookings.map((car) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Column(children: [Row(children: [Container(width: 64, height: 58, decoration: BoxDecoration(color: car.color, borderRadius: BorderRadius.circular(14)), child: Icon(car.icon, color: ink, size: 34)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(car.name, style: const TextStyle(fontWeight: FontWeight.w800, color: ink)), const SizedBox(height: 4), const Text('ยืนยันแล้ว • เตรียมรับรถ', style: TextStyle(color: green, fontSize: 12))])), const Icon(Icons.more_horiz, color: muted)]), const Divider(height: 24), const Row(children: [Icon(Icons.calendar_month_outlined, size: 17, color: muted), SizedBox(width: 7), Text('ตามวันที่เลือกไว้ • 2 วัน', style: TextStyle(color: muted, fontSize: 12)), Spacer(), Icon(Icons.location_on_outlined, size: 16, color: muted), SizedBox(width: 4), Text('กรุงเทพฯ', style: TextStyle(color: muted, fontSize: 12))])]))),
    ]),
  ));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(20, 22, 20, 26), children: [
    const Text('โปรไฟล์', style: TextStyle(color: ink, fontSize: 24, fontWeight: FontWeight.w800)),
    const SizedBox(height: 18),
    Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(22)), child: Row(children: [const CircleAvatar(radius: 29, backgroundColor: lime, child: Icon(Icons.person, color: ink, size: 30)), const SizedBox(width: 14), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('คุณนักเดินทาง', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('student@university.ac.th', style: TextStyle(color: Colors.white70, fontSize: 12))])), IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined, color: Colors.white))])),
    const SizedBox(height: 22),
    const Text('บัญชีของฉัน', style: TextStyle(color: ink, fontWeight: FontWeight.w800, fontSize: 16)),
    const SizedBox(height: 9),
    const ProfileOption(icon: Icons.badge_outlined, title: 'ข้อมูลส่วนตัว', subtitle: 'ชื่อ เบอร์โทร และอีเมล'),
    const ProfileOption(icon: Icons.credit_card_outlined, title: 'วิธีชำระเงิน', subtitle: 'จัดการช่องทางชำระเงิน'),
    const ProfileOption(icon: Icons.shield_outlined, title: 'ความปลอดภัย', subtitle: 'รหัสผ่านและการยืนยันตัวตน'),
    const SizedBox(height: 15),
    const Text('ช่วยเหลือ', style: TextStyle(color: ink, fontWeight: FontWeight.w800, fontSize: 16)),
    const SizedBox(height: 9),
    const ProfileOption(icon: Icons.help_outline, title: 'ศูนย์ช่วยเหลือ', subtitle: 'คำถามที่พบบ่อยและติดต่อเรา'),
    const ProfileOption(icon: Icons.info_outline, title: 'เกี่ยวกับ MOOVE', subtitle: 'แอปต้นแบบสำหรับการเรียน'),
    const SizedBox(height: 14),
    const Text('เวอร์ชัน 1.0.0 • โปรเจกต์ตัวอย่าง', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 11)),
  ]));
}

class CarCard extends StatelessWidget {
  const CarCard({required this.car, required this.onTap, super.key});
  final Car car;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFEAEDF2))), child: Row(children: [
      CarArtwork(car: car, height: 92, width: 112, rounded: 15),
      const SizedBox(width: 13),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(car.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: ink, fontWeight: FontWeight.w800, fontSize: 14))), ValueListenableBuilder<Set<String>>(valueListenable: FavoriteStore.ids, builder: (context, ids, _) => InkWell(onTap: () => FavoriteStore.toggle(car.id), child: Icon(ids.contains(car.id) ? Icons.favorite : Icons.favorite_border, color: ids.contains(car.id) ? Colors.redAccent : muted, size: 20)))]), const SizedBox(height: 4), Text(car.kind, style: const TextStyle(color: muted, fontSize: 11)), const SizedBox(height: 8), Row(children: [const Icon(Icons.star_rounded, color: Color(0xFFFFB547), size: 15), const SizedBox(width: 3), Text(car.rating, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)), const Spacer(), Text('฿${car.price}', style: const TextStyle(color: ink, fontWeight: FontWeight.w900, fontSize: 15)), const Text(' /วัน', style: TextStyle(color: muted, fontSize: 10))])])),
    ])),
  );
}

class CarArtwork extends StatelessWidget {
  const CarArtwork({required this.car, required this.height, required this.rounded, this.width, super.key});
  final Car car;
  final double height;
  final double? width;
  final double rounded;

  @override
  Widget build(BuildContext context) => Container(width: width, height: height, clipBehavior: Clip.antiAlias, decoration: BoxDecoration(color: car.color, borderRadius: BorderRadius.circular(rounded)), child: Stack(children: [Positioned(right: -10, bottom: -12, child: Icon(car.icon, size: height * 1.05, color: ink.withOpacity(.72))), Positioned(left: 10, top: 9, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(.86), borderRadius: BorderRadius.circular(12)), child: Text(car.tag, style: const TextStyle(color: ink, fontSize: 9, fontWeight: FontWeight.w800))))]));
}

class PriceLabel extends StatelessWidget {
  const PriceLabel({required this.price, super.key});
  final int price;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('ราคาเริ่มต้น', style: TextStyle(fontSize: 11, color: muted)), Text('฿$price', style: const TextStyle(color: ink, fontWeight: FontWeight.w900, fontSize: 21)), const Text('/ วัน', style: TextStyle(color: muted, fontSize: 10))]);
}

class SpecPill extends StatelessWidget {
  const SpecPill({required this.icon, required this.label, super.key});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(child: Container(margin: const EdgeInsets.only(right: 7), padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)), child: Column(children: [Icon(icon, color: ink, size: 19), const SizedBox(height: 5), Text(label, style: const TextStyle(fontSize: 10, color: muted), maxLines: 1, overflow: TextOverflow.ellipsis)])));
}

class DetailBullet extends StatelessWidget {
  const DetailBullet({required this.icon, required this.text, super.key});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 9), child: Row(children: [Icon(icon, color: green, size: 17), const SizedBox(width: 8), Text(text, style: const TextStyle(color: muted, fontSize: 12))]));
}

class DateTile extends StatelessWidget {
  const DateTile({required this.label, required this.date, required this.onTap, super.key});
  final String label;
  final String date;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [const Icon(Icons.calendar_month_outlined, color: ink), const SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: muted, fontSize: 11)), Text(date, style: const TextStyle(color: ink, fontWeight: FontWeight.w700))])), const Icon(Icons.edit_calendar_outlined, color: muted, size: 19)])));
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({required this.label, required this.value, this.strong = false, super.key});
  final String label;
  final String value;
  final bool strong;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Row(children: [Expanded(child: Text(label, style: TextStyle(color: strong ? ink : muted, fontSize: strong ? 14 : 12, fontWeight: strong ? FontWeight.w800 : FontWeight.w500))), Text(value, style: TextStyle(color: ink, fontSize: strong ? 16 : 12, fontWeight: strong ? FontWeight.w900 : FontWeight.w700))]));
}

class ProfileOption extends StatelessWidget {
  const ProfileOption({required this.icon, required this.title, required this.subtitle, super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [Container(width: 39, height: 39, decoration: BoxDecoration(color: canvas, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: ink, size: 20)), const SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.w700, fontSize: 13)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: muted, fontSize: 10))])), const Icon(Icons.chevron_right, color: muted)]));
}

class EmptyState extends StatelessWidget {
  const EmptyState({required this.icon, required this.title, required this.subtitle, super.key});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 58, horizontal: 22), child: Column(children: [Container(width: 74, height: 74, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)), child: Icon(icon, color: muted, size: 32)), const SizedBox(height: 15), Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.w800, fontSize: 17)), const SizedBox(height: 7), Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: muted, height: 1.4, fontSize: 12))]));
}
