import '../../../shared/app_imports/app_imports.dart';

class BlogController extends GetxController {
  RxList<Map<String, dynamic>> blogs = <Map<String, dynamic>>[].obs;
  RxBool isRewarding = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBlogs();
  }

  void loadBlogs() {
    blogs.value = [
      {
        'title': 'The Future of Cryptocurrency',
        'subtitle': 'Opportunities and Challenges Ahead',
        'content': '''
Cryptocurrency has grown from a niche technological experiment into a global financial phenomenon. 
What started with Bitcoin in 2009 as a decentralized alternative to traditional money has now expanded 
into a trillion-dollar industry with thousands of digital assets, blockchain networks, and financial applications.

The Current Landscape of Cryptocurrency:
- Powers DeFi, NFTs, metaverse economies, cross-border payments.
- Countries like El Salvador adopted Bitcoin; others building CBDCs.
- Crypto is evolving, not disappearing.

Opportunities:
1. Global Financial Inclusion – Banking services for the unbanked via smartphones.
2. Decentralized Finance (DeFi) – Transparent, accessible financial systems.
3. Cross-Border Payments – Faster, cheaper international transfers.
4. Integration with AI, IoT, Web3 – Smart contracts and digital ownership.

Challenges:
1. Regulatory Uncertainty – Need for clear frameworks.
2. Volatility – Stablecoins and CBDCs may help.
3. Security Risks – Hacks and scams require stronger defenses.
4. Environmental Concerns – Shift to eco-friendly proof-of-stake.

Predictions for the Next Decade:
- Mainstream adoption of crypto payments.
- Government-backed hybrid systems.
- Metaverse economies and Web3 growth.

Conclusion:
Cryptocurrency promises global inclusion and innovation, but must solve regulation, volatility, and security challenges.
''',
        'image': AppImages.p1,
      },
      {
        'title': 'The Rise of Crypto Games',
        'subtitle': 'Where Blockchain Meets Entertainment',
        'content': '''
Gaming has evolved from pure entertainment into an economy where players earn real-world value. 
Crypto games (play-to-earn) use blockchain and cryptocurrencies to give players true ownership of digital assets.

What Are Crypto Games?
- In-game items as NFTs/tokens with real trade value.
- Earn crypto for achievements and gameplay.
- Build long-term value from time and money spent.

How Do They Work?
- Built on Ethereum, BSC, Polygon, or gaming chains.
- Completing quests earns tokens exchangeable for real money.
- Items can be sold in marketplaces.

Popular Examples:
- Axie Infinity, The Sandbox, Decentraland, Gods Unchained.

Benefits:
1. Player Ownership – Control digital assets.
2. Earning Potential – Play-to-earn income.
3. Transparency – Blockchain ensures fairness.
4. Global Access – Open to anyone online.

Challenges:
- Volatility of tokens.
- Scams and fake projects.
- High entry costs for some games.
- Regulatory uncertainty.

The Future:
- GameFi growth with mainstream studios.
- Interoperable NFTs across games.
- VR/metaverse integration for immersive experiences.

Conclusion:
Crypto games create digital economies merging play, work, and investment into one experience.
''',
        'image': AppImages.p2,
      },
      {
        'title': 'Understanding Crypto Mining',
        'subtitle': 'The Backbone of Blockchain',
        'content': '''
Crypto mining validates transactions and secures blockchains. Miners solve mathematical puzzles 
using powerful computers, adding blocks to the chain and earning coins as rewards.

How It Works:
1. Verify transactions → form a block.
2. Solve cryptographic puzzle (proof-of-work).
3. First to solve validates block and earns coins.

Types of Mining:
- CPU: Easy but unprofitable.
- GPU: Faster, popular for Ethereum (pre-PoS).
- ASIC: Specialized, highly efficient for Bitcoin.
- Cloud: Rent power remotely but risk scams.

Benefits:
- Income from coins and fees.
- Network security and decentralization.

Challenges:
1. High Energy Consumption – Like small countries.
2. Expensive Equipment – GPUs and ASICs costly.
3. Increasing Difficulty – Reduced profitability.
4. Regulatory Pressure – Some countries ban mining.

The Future:
- Shift to proof-of-stake (PoS) validators.
- Green mining using renewable energy.
- Mining pools share rewards fairly.

Conclusion:
Mining is crucial to blockchain history, but the industry is moving toward greener, sustainable security models.
''',
        'image': AppImages.p3,
      },
    ];
  }

  /// 3-second reward: +0.1 coin to current user, then stop loading
  Future<void> rewardUser(String uid) async {
    isRewarding.value = true;
    await Future.delayed(const Duration(seconds: 3));

    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final snap = await docRef.get();
    if (snap.exists) {
      final current = (snap['totalCoin'] as num).toDouble();
      final updated = current + 0.1;
      await docRef.update({
        'totalCoin': double.parse(updated.toStringAsFixed(5)), // store nicely
      });
    }

    isRewarding.value = false;
  }
}
