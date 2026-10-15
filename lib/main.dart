import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const PuzzleApp());

const night = Color(0xFF15172D);
const panel = Color(0xFF232641);
const panelLight = Color(0xFF303452);
const cream = Color(0xFFFFF5DE);
const muted = Color(0xFFB7BAD2);
const yellow = Color(0xFFFFD45E);
const coral = Color(0xFFFF846B);
const mint = Color(0xFF81E4C2);
const artFiles = ['sunrise.svg','forest.svg','coast.svg','desert.svg','meadow.svg','mountains.svg','autumn.svg','night.svg'];
const artNames = ['Golden Horizon','Misty Forest','Blue Coast','Desert Dream','Wildflower','Alpine Light','Autumn Path','Moonlit Peaks'];

void push(BuildContext c, Widget page) => Navigator.of(c).push(MaterialPageRoute(builder: (_) => page));
void replace(BuildContext c, Widget page) => Navigator.of(c).pushReplacement(MaterialPageRoute(builder: (_) => page));

class PuzzleApp extends StatelessWidget {
  const PuzzleApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Art Block Puzzle', debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true, brightness: Brightness.dark, scaffoldBackgroundColor: night,
      colorScheme: ColorScheme.fromSeed(seedColor: yellow, brightness: Brightness.dark),
      fontFamily: 'Roboto',
    ),
    home: const SplashScreen(),
  );
}

class Art extends StatelessWidget {
  final String file; final double? h, w; final BorderRadius radius;
  const Art(this.file, {super.key, this.h, this.w, this.radius = const BorderRadius.all(Radius.circular(18))});
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: radius,
    child: SvgPicture.asset('assets/artwork/$file', height: h, width: w, fit: BoxFit.cover),
  );
}

class GameBackground extends StatelessWidget {
  final Widget child; const GameBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(gradient: LinearGradient(
      begin: Alignment.topLeft, end: Alignment.bottomRight,
      colors: [Color(0xFF252849), night, Color(0xFF101221)],
    )),
    child: Stack(children: [
      Positioned(top: -100, right: -75, child: _Glow(color: Color(0x22FF846B), size: 250)),
      Positioned(bottom: -125, left: -75, child: _Glow(color: Color(0x1E81E4C2), size: 270)),
      SafeArea(child: child),
    ]),
  );
}
class _Glow extends StatelessWidget {
  final Color color; final double size; const _Glow({required this.color, required this.size});
  @override Widget build(BuildContext context) => Container(width:size,height:size,decoration:BoxDecoration(shape:BoxShape.circle,color:color));
}

class GameButton extends StatelessWidget {
  final String label; final VoidCallback onTap; final IconData icon; final bool secondary;
  const GameButton(this.label, this.onTap, {super.key, this.icon = Icons.play_arrow_rounded, this.secondary = false});
  @override Widget build(BuildContext context) => SizedBox(
    height: 58, width: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: secondary ? null : const LinearGradient(colors: [Color(0xFFFFE17B), yellow, Color(0xFFFFB94D)]),
        color: secondary ? panelLight : null,
        borderRadius: BorderRadius.circular(20),
        boxShadow: secondary ? [] : [BoxShadow(color: yellow.withOpacity(.19), blurRadius: 18, offset: const Offset(0, 7))],
        border: secondary ? Border.all(color: Colors.white12) : null,
      ),
      child: Material(color: Colors.transparent, child: InkWell(
        borderRadius: BorderRadius.circular(20), onTap: onTap,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: secondary ? cream : night, size: 25),
          const SizedBox(width: 9),
          Text(label, style: TextStyle(color: secondary ? cream : night, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: .2)),
        ]),
      )),
    ),
  );
}

class RoundIcon extends StatelessWidget {
  final IconData icon; final VoidCallback onTap; const RoundIcon(this.icon, this.onTap, {super.key});
  @override Widget build(BuildContext context) => Material(
    color: Colors.white.withOpacity(.08), shape: const CircleBorder(),
    child: InkWell(customBorder: const CircleBorder(), onTap: onTap, child: SizedBox(width:44,height:44,child:Icon(icon,color:cream))),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    body: GameBackground(child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 26),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width:54,height:54,decoration:BoxDecoration(gradient:const LinearGradient(colors:[yellow,coral]),borderRadius:BorderRadius.circular(18)),child:const Icon(Icons.extension_rounded,color:night,size:33)),
          const SizedBox(width:12),
          const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text('ART BLOCK',style:TextStyle(fontSize:22,fontWeight:FontWeight.w900,letterSpacing:1.3,color:cream)),
            Text('PUZZLE QUEST',style:TextStyle(fontSize:10,fontWeight:FontWeight.w900,letterSpacing:3,color:yellow)),
          ]),
        ]),
        const Spacer(),
        Transform.rotate(angle:-.045,child:Container(
          padding:const EdgeInsets.all(10),
          decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(28),border:Border.all(color:Colors.white12),boxShadow:const [BoxShadow(color:Colors.black38,blurRadius:25,offset:Offset(0,14))]),
          child:Stack(alignment:Alignment.bottomLeft,children:[
            const Art('sunrise.svg',h:310,w:500),
            Container(height:95,decoration:const BoxDecoration(gradient:LinearGradient(begin:Alignment.bottomCenter,end:Alignment.topCenter,colors:[Color(0xDD111326),Colors.transparent]))),
            const Padding(padding:EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text('PIECE BY PIECE',style:TextStyle(color:yellow,fontSize:11,fontWeight:FontWeight.w900,letterSpacing:2)),
              Text('Make the art\ncome alive.',style:TextStyle(color:Colors.white,fontSize:30,height:1.05,fontWeight:FontWeight.w900)),
            ])),
          ]),
        )),
        const SizedBox(height:25),
        const Text('Drag. Drop. Discover.',style:TextStyle(color:muted,fontSize:16)),
        const SizedBox(height:18),
        GameButton('LET’S PLAY',()=>replace(context,const Home()),icon:Icons.rocket_launch_rounded),
        const SizedBox(height:14),
        const Center(child:Text('A tiny puzzle adventure',style:TextStyle(color:Color(0xFF8589AB),fontSize:12,fontWeight:FontWeight.w600))),
      ]),
    )),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override Widget build(BuildContext context) => Scaffold(body:GameBackground(child:ListView(
    padding:const EdgeInsets.fromLTRB(20,12,20,28),
    children:[
      Row(children:[
        Container(width:45,height:45,decoration:BoxDecoration(gradient:const LinearGradient(colors:[yellow,coral]),borderRadius:BorderRadius.circular(15)),child:const Icon(Icons.extension_rounded,color:night,size:28)),
        const SizedBox(width:10),
        const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text('ART BLOCK',style:TextStyle(color:cream,fontWeight:FontWeight.w900,fontSize:18,letterSpacing:1.1)),
          Text('PUZZLE QUEST',style:TextStyle(color:yellow,fontWeight:FontWeight.w900,fontSize:9,letterSpacing:2.4)),
        ])),
        Container(padding:const EdgeInsets.symmetric(horizontal:13,vertical:9),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.white10)),child:const Row(children:[Icon(Icons.monetization_on_rounded,color:yellow,size:20),SizedBox(width:5),Text('240',style:TextStyle(color:cream,fontWeight:FontWeight.w900))])),
        const SizedBox(width:8), RoundIcon(Icons.settings_rounded,()=>push(context,const SettingsScreen())),
      ]),
      const SizedBox(height:26),
      const Text('READY,\nPUZZLER?',style:TextStyle(color:cream,fontSize:38,height:.98,fontWeight:FontWeight.w900,letterSpacing:-1)),
      const SizedBox(height:8),
      const Text('Put the pieces together. Reveal something beautiful.',style:TextStyle(color:muted,fontSize:13,height:1.4)),
      const SizedBox(height:20),
      GestureDetector(onTap:()=>push(context,const PlayScreen(file:'sunrise.svg',title:'Golden Horizon',grid:3)),child:Container(
        padding:const EdgeInsets.all(10),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(26),border:Border.all(color:Colors.white12),boxShadow:const [BoxShadow(color:Colors.black26,blurRadius:18,offset:Offset(0,8))]),
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Stack(children:[
            const Art('sunrise.svg',h:190,w:500),
            Positioned(left:12,top:12,child:Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:7),decoration:BoxDecoration(color:yellow,borderRadius:BorderRadius.circular(10)),child:const Text('CONTINUE',style:TextStyle(color:night,fontSize:10,fontWeight:FontWeight.w900,letterSpacing:1)))),
            const Positioned(right:12,top:12,child:Icon(Icons.star_rounded,color:yellow,size:28)),
          ]),
          const SizedBox(height:13),
          const Padding(padding:EdgeInsets.symmetric(horizontal:6),child:Row(children:[
            Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
              Text('Golden Horizon',style:TextStyle(color:cream,fontSize:19,fontWeight:FontWeight.w900)),
              SizedBox(height:3),Text('LANDSCAPE SERIES  •  9 PIECES',style:TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w800,letterSpacing:1)),
            ])),
            Icon(Icons.play_circle_fill_rounded,color:yellow,size:42),
          ])),
          const SizedBox(height:6),
        ]),
      )),
      const SizedBox(height:18),
      GameButton('PLAY PUZZLE',()=>push(context,const LevelsScreen()),icon:Icons.extension_rounded),
      const SizedBox(height:16),
      Row(children:[
        Expanded(child:_HomeTile(icon:Icons.calendar_month_rounded,title:'DAILY QUEST',caption:'New art every day',accent:coral,onTap:()=>push(context,const PlayScreen(file:'meadow.svg',title:'Wildflower',grid:3)))),
        const SizedBox(width:12),
        Expanded(child:_HomeTile(icon:Icons.photo_library_rounded,title:'ART WORLDS',caption:'Explore collections',accent:mint,onTap:()=>push(context,const LevelsScreen()))),
      ]),
      const SizedBox(height:17),
      Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(22),border:Border.all(color:Colors.white10)),child:Row(children:[
        const Icon(Icons.emoji_events_rounded,color:yellow,size:30),const SizedBox(width:12),
        const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('PUZZLE CHAMPION',style:TextStyle(color:cream,fontWeight:FontWeight.w900)),SizedBox(height:3),Text('Keep your streak going!',style:TextStyle(color:muted,fontSize:12))])),
        TextButton(onPressed:()=>push(context,const StatsScreen()),child:const Text('STATS',style:TextStyle(color:yellow,fontWeight:FontWeight.w900))),
      ])),
    ],
  )));

}

class _HomeTile extends StatelessWidget {
  final IconData icon;final String title,caption;final Color accent;final VoidCallback onTap;
  const _HomeTile({required this.icon,required this.title,required this.caption,required this.accent,required this.onTap});
  @override Widget build(BuildContext context)=>Material(color:panel,borderRadius:BorderRadius.circular(20),child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(20),child:Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white10)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Container(width:40,height:40,decoration:BoxDecoration(color:accent.withOpacity(.16),borderRadius:BorderRadius.circular(13)),child:Icon(icon,color:accent,size:23)),
    const SizedBox(height:13),Text(title,style:const TextStyle(color:cream,fontSize:12,fontWeight:FontWeight.w900,letterSpacing:.5)),
    const SizedBox(height:4),Text(caption,style:const TextStyle(color:muted,fontSize:11)),
  ]))));
}

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(body:GameBackground(child:ListView(padding:const EdgeInsets.fromLTRB(18,12,18,25),children:[
    Row(children:[RoundIcon(Icons.arrow_back_rounded,()=>Navigator.pop(context)),const SizedBox(width:12),const Text('CHOOSE YOUR QUEST',style:TextStyle(color:cream,fontSize:19,fontWeight:FontWeight.w900,letterSpacing:.5))]),
    const SizedBox(height:9),const Text('Pick an artwork and choose your challenge.',style:TextStyle(color:muted)),
    const SizedBox(height:20),
    ...List.generate(artFiles.length,(i)=>Padding(padding:const EdgeInsets.only(bottom:12),child:Material(color:panel,borderRadius:BorderRadius.circular(20),child:InkWell(borderRadius:BorderRadius.circular(20),onTap:()=>push(context,PlayScreen(file:artFiles[i],title:artNames[i],grid:i%2==0?3:4)),child:Padding(padding:const EdgeInsets.all(10),child:Row(children:[
      Art(artFiles[i],h:86,w:104,radius:BorderRadius.circular(14)),const SizedBox(width:13),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(artNames[i],style:const TextStyle(color:cream,fontWeight:FontWeight.w900,fontSize:15)),
        const SizedBox(height:5),Text(i%2==0?'BEGINNER • 9 PIECES':'PUZZLE PRO • 16 PIECES',style:const TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w800,letterSpacing:.6)),
        const SizedBox(height:8),Row(children:List.generate(3,(s)=>Icon(Icons.star_rounded,size:15,color:s<((i%3)+1)?yellow:Colors.white12))),
      ])),
      const Icon(Icons.play_circle_fill_rounded,color:yellow,size:34),
    ])))))),
  ])));

}

class PlayScreen extends StatefulWidget {
  final String file,title; final int grid;
  const PlayScreen({super.key,required this.file,required this.title,this.grid=3});
  @override State<PlayScreen> createState()=>_PlayScreenState();
}
class _PlayScreenState extends State<PlayScreen> {
  late List<int> tray;
  final Set<int> placed={};
  int mistakes=0;
  bool showPreview=false;
  @override void initState(){super.initState();tray=List.generate(widget.grid*widget.grid,(i)=>i)..shuffle(Random());}
  void _drop(int piece,int target){
    if(piece==target){
      if(!placed.contains(target)){setState(()=>placed.add(target));HapticFeedback.lightImpact();}
      if(placed.length==widget.grid*widget.grid){
        Future.delayed(const Duration(milliseconds:450),(){if(mounted)push(context,CompleteScreen(file:widget.file,title:widget.title,grid:widget.grid));});
      }
    }else{
      setState(()=>mistakes++);
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Not quite! Try matching the picture edges.'),duration:Duration(milliseconds:900),behavior:SnackBarBehavior.floating));
    }
  }
  @override Widget build(BuildContext context)=>Scaffold(body:GameBackground(child:LayoutBuilder(builder:(context,constraints){
    final screenW=constraints.maxWidth;
    final boardSide=min(screenW-36,390.0);
    final tileSide=boardSide/widget.grid;
    final remaining=tray.where((i)=>!placed.contains(i)).toList();
    return Column(children:[
      Padding(padding:const EdgeInsets.fromLTRB(16,8,16,8),child:Row(children:[
        RoundIcon(Icons.close_rounded,()=>showDialog(context:context,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('Leave puzzle?',style:TextStyle(color:cream,fontWeight:FontWeight.w900)),content:const Text('Your current round will end.',style:TextStyle(color:muted)),actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('KEEP PLAYING')),TextButton(onPressed:(){Navigator.pop(d);Navigator.pop(context);},child:const Text('LEAVE'))]))),
        const SizedBox(width:12),
        Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(widget.title.toUpperCase(),maxLines:1,overflow:TextOverflow.ellipsis,style:const TextStyle(color:cream,fontWeight:FontWeight.w900,fontSize:14,letterSpacing:.7)),
          Text(widget.grid==3?'JUNIOR PUZZLE • 3 × 3':'PUZZLE PRO • 4 × 4',style:const TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w800,letterSpacing:1)),
        ])),
        RoundIcon(Icons.visibility_rounded,()=>showDialog(context:context,builder:(d)=>Dialog(backgroundColor:panel,child:Padding(padding:const EdgeInsets.all(12),child:Column(mainAxisSize:MainAxisSize.min,children:[const Text('PICTURE PREVIEW',style:TextStyle(color:yellow,fontWeight:FontWeight.w900,letterSpacing:1)),const SizedBox(height:12),Art(widget.file,w:320,h:230),const SizedBox(height:12),TextButton(onPressed:()=>Navigator.pop(d),child:const Text('GOT IT'))])))),
      ])),
      Padding(padding:const EdgeInsets.symmetric(horizontal:20,vertical:5),child:Row(children:[
        const Icon(Icons.extension_rounded,color:yellow,size:18),const SizedBox(width:7),
        Text('${placed.length} / ${widget.grid*widget.grid} PIECES',style:const TextStyle(color:cream,fontWeight:FontWeight.w900,fontSize:11,letterSpacing:1)),
        const Spacer(),Icon(Icons.bolt_rounded,color:coral,size:17),Text(' ${mistakes} misses',style:const TextStyle(color:muted,fontSize:11)),
      ])),
      Padding(padding:const EdgeInsets.symmetric(horizontal:20),child:ClipRRect(borderRadius:BorderRadius.circular(10),child:LinearProgressIndicator(value:placed.length/(widget.grid*widget.grid),minHeight:7,backgroundColor:Colors.white10,color:mint))),
      const SizedBox(height:13),
      Container(padding:const EdgeInsets.all(7),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(22),border:Border.all(color:Colors.white12),boxShadow:const [BoxShadow(color:Colors.black26,blurRadius:20,offset:Offset(0,8))]),child:SizedBox(width:boardSide,height:boardSide,child:GridView.builder(
        physics:const NeverScrollableScrollPhysics(),padding:EdgeInsets.zero,gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:widget.grid,crossAxisSpacing:3,mainAxisSpacing:3),itemCount:widget.grid*widget.grid,
        itemBuilder:(ctx,index)=>DragTarget<int>(
          onWillAcceptWithDetails:(details)=>true,
          onAcceptWithDetails:(details)=>_drop(details.data,index),
          builder:(ctx,candidates,rejects)=>AnimatedContainer(duration:const Duration(milliseconds:180),decoration:BoxDecoration(color:placed.contains(index)?Colors.transparent:const Color(0xFF17192F),borderRadius:BorderRadius.circular(widget.grid==3?7:4),border:Border.all(color:candidates.isNotEmpty?yellow:(placed.contains(index)?mint.withOpacity(.7):Colors.white24),width:candidates.isNotEmpty?2:1)),child:placed.contains(index)?ArtSlice(file:widget.file,index:index,grid:widget.grid,size:tileSide):Center(child:candidates.isNotEmpty?const Icon(Icons.add_rounded,color:yellow,size:22):Text('＋',style:TextStyle(color:Colors.white.withOpacity(.16),fontSize:widget.grid==3?22:15,fontWeight:FontWeight.w300)))),
        ),
      ))),
      const SizedBox(height:12),
      Padding(padding:const EdgeInsets.symmetric(horizontal:22),child:Row(children:[
        const Text('PIECE TRAY',style:TextStyle(color:cream,fontSize:12,fontWeight:FontWeight.w900,letterSpacing:1.4)),
        const Spacer(),Text('${remaining.length} LEFT',style:const TextStyle(color:muted,fontSize:10,fontWeight:FontWeight.w800)),
      ])),
      const SizedBox(height:8),
      Expanded(child:Padding(padding:const EdgeInsets.symmetric(horizontal:16),child:remaining.isEmpty?const Center(child:Text('Amazing! Artwork restored!',style:TextStyle(color:mint,fontWeight:FontWeight.w900))):SingleChildScrollView(child:Wrap(alignment:WrapAlignment.center,spacing:8,runSpacing:8,children:remaining.map((piece)=>Draggable<int>(
        data:piece,
        feedback:Material(color:Colors.transparent,child:Container(width:tileSide+8,height:tileSide+8,padding:const EdgeInsets.all(2),decoration:BoxDecoration(color:yellow,borderRadius:BorderRadius.circular(10),boxShadow:const [BoxShadow(color:Colors.black45,blurRadius:15)]),child:ArtSlice(file:widget.file,index:piece,grid:widget.grid,size:tileSide+4))),
        childWhenDragging:Opacity(opacity:.15,child:_TrayPiece(file:widget.file,index:piece,grid:widget.grid,size:min(tileSide-2,widget.grid==3?88.0:70.0))),
        child:_TrayPiece(file:widget.file,index:piece,grid:widget.grid,size:min(tileSide-2,widget.grid==3?88.0:70.0)),
      )).toList())))),
      Padding(padding:const EdgeInsets.fromLTRB(20,4,20,12),child:Row(children:[
        Expanded(child:_ToolButton(icon:Icons.shuffle_rounded,label:'SHUFFLE',onTap:()=>setState(()=>tray.shuffle(Random())))),
        const SizedBox(width:9),Expanded(child:_ToolButton(icon:Icons.lightbulb_rounded,label:'HINT',onTap:(){
          final missing=List.generate(widget.grid*widget.grid,(i)=>i).where((i)=>!placed.contains(i)).firstOrNull;
          if(missing!=null){setState(()=>tray=[...tray.where((i)=>i!=missing),missing]);ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Hint: look for the piece that belongs in the next open spot.'),behavior:SnackBarBehavior.floating));}
        })),
        const SizedBox(width:9),Expanded(child:_ToolButton(icon:Icons.refresh_rounded,label:'RESTART',onTap:()=>setState((){placed.clear();mistakes=0;tray=List.generate(widget.grid*widget.grid,(i)=>i)..shuffle(Random());}))),
      ])),
    ]);
  })));
}

class ArtSlice extends StatelessWidget {
  final String file;final int index,grid;final double size;
  const ArtSlice({super.key,required this.file,required this.index,required this.grid,required this.size});
  @override Widget build(BuildContext context){
    final row=index~/grid,col=index%grid,full=size*grid;
    return ClipRRect(borderRadius:BorderRadius.circular(3),child:SizedBox(width:size,height:size,child:Stack(clipBehavior:Clip.hardEdge,children:[
      Positioned(left:-col*size,top:-row*size,width:full,height:full,child:Art(file,w:full,h:full,radius:BorderRadius.zero)),
    ])));
  }
}
class _TrayPiece extends StatelessWidget {
  final String file;final int index,grid;final double size;
  const _TrayPiece({required this.file,required this.index,required this.grid,required this.size});
  @override Widget build(BuildContext context)=>Container(width:size,height:size,padding:const EdgeInsets.all(2),decoration:BoxDecoration(color:panelLight,borderRadius:BorderRadius.circular(10),border:Border.all(color:Colors.white24),boxShadow:const [BoxShadow(color:Colors.black12,blurRadius:5,offset:Offset(0,3))]),child:ArtSlice(file:file,index:index,grid:grid,size:size-4));
}
class _ToolButton extends StatelessWidget {
  final IconData icon;final String label;final VoidCallback onTap;
  const _ToolButton({required this.icon,required this.label,required this.onTap});
  @override Widget build(BuildContext context)=>Material(color:panel,borderRadius:BorderRadius.circular(15),child:InkWell(onTap:onTap,borderRadius:BorderRadius.circular(15),child:Container(padding:const EdgeInsets.symmetric(vertical:11),decoration:BoxDecoration(borderRadius:BorderRadius.circular(15),border:Border.all(color:Colors.white10)),child:Column(children:[Icon(icon,color:yellow,size:20),const SizedBox(height:4),Text(label,style:const TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w900,letterSpacing:.5))]))));
}

class CompleteScreen extends StatelessWidget {
  final String file,title;final int grid;
  const CompleteScreen({super.key,required this.file,required this.title,required this.grid});
  @override Widget build(BuildContext context)=>Scaffold(body:GameBackground(child:Center(child:SingleChildScrollView(padding:const EdgeInsets.all(22),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
    Container(width:86,height:86,decoration:BoxDecoration(shape:BoxShape.circle,color:yellow.withOpacity(.15),border:Border.all(color:yellow,width:2)),child:const Icon(Icons.emoji_events_rounded,color:yellow,size:48)),
    const SizedBox(height:18),const Text('PUZZLE CLEARED!',style:TextStyle(color:yellow,fontSize:13,fontWeight:FontWeight.w900,letterSpacing:3)),
    const SizedBox(height:6),const Text('YOU DID IT!',style:TextStyle(color:cream,fontSize:34,fontWeight:FontWeight.w900)),
    const SizedBox(height:20),Container(padding:const EdgeInsets.all(10),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(25),border:Border.all(color:yellow.withOpacity(.35))),child:Art(file,h:250,w:500)),
    const SizedBox(height:18),Text(title,style:const TextStyle(color:cream,fontSize:22,fontWeight:FontWeight.w900)),
    const SizedBox(height:8),const Row(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.star_rounded,color:yellow,size:35),Icon(Icons.star_rounded,color:yellow,size:43),Icon(Icons.star_rounded,color:yellow,size:35)]),
    const SizedBox(height:5),Text('${grid*grid} PIECES RESTORED  •  +80 COINS',style:const TextStyle(color:mint,fontWeight:FontWeight.w900,fontSize:11,letterSpacing:.8)),
    const SizedBox(height:24),GameButton('NEXT ARTWORK',()=>replace(context,PlayScreen(file:artFiles[(artFiles.indexOf(file)+1)%artFiles.length],title:artNames[(artFiles.indexOf(file)+1)%artFiles.length],grid:grid)),icon:Icons.arrow_forward_rounded),
    const SizedBox(height:12),GameButton('BACK TO HOME',()=>Navigator.of(context).popUntil((route)=>route.isFirst),secondary:true,icon:Icons.home_rounded),
  ])))));
}

class SettingsScreen extends StatefulWidget {const SettingsScreen({super.key});@override State<SettingsScreen> createState()=>_SettingsScreenState();}
class _SettingsScreenState extends State<SettingsScreen>{
  bool sound=true,music=true,haptics=true;
  @override Widget build(BuildContext context)=>Scaffold(body:GameBackground(child:ListView(padding:const EdgeInsets.all(20),children:[
    Row(children:[RoundIcon(Icons.arrow_back_rounded,()=>Navigator.pop(context)),const SizedBox(width:12),const Text('GAME SETTINGS',style:TextStyle(color:cream,fontSize:19,fontWeight:FontWeight.w900))]),
    const SizedBox(height:20),
    _SettingCard(icon:Icons.volume_up_rounded,title:'Sound effects',subtitle:'Piece drops and game feedback',value:sound,onChanged:(v)=>setState(()=>sound=v)),
    _SettingCard(icon:Icons.music_note_rounded,title:'Background music',subtitle:'Keep the adventure going',value:music,onChanged:(v)=>setState(()=>music=v)),
    _SettingCard(icon:Icons.vibration_rounded,title:'Haptic feedback',subtitle:'Feel every perfect placement',value:haptics,onChanged:(v)=>setState(()=>haptics=v)),
  ])));
}
class _SettingCard extends StatelessWidget {
  final IconData icon;final String title,subtitle;final bool value;final ValueChanged<bool> onChanged;
  const _SettingCard({required this.icon,required this.title,required this.subtitle,required this.value,required this.onChanged});
  @override Widget build(BuildContext context)=>Container(margin:const EdgeInsets.only(bottom:12),padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(18),border:Border.all(color:Colors.white10)),child:Row(children:[Icon(icon,color:yellow,size:25),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(color:cream,fontWeight:FontWeight.w900)),Text(subtitle,style:const TextStyle(color:muted,fontSize:11))])),Switch(value:value,onChanged:onChanged,activeColor:yellow)]));
}
class StatsScreen extends StatelessWidget {const StatsScreen({super.key});@override Widget build(BuildContext context)=>Scaffold(body:GameBackground(child:ListView(padding:const EdgeInsets.all(20),children:[
  Row(children:[RoundIcon(Icons.arrow_back_rounded,()=>Navigator.pop(context)),const SizedBox(width:12),const Text('PLAYER STATS',style:TextStyle(color:cream,fontSize:19,fontWeight:FontWeight.w900))]),
  const SizedBox(height:22),Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(24),border:Border.all(color:Colors.white10)),child:const Column(children:[
    Icon(Icons.workspace_premium_rounded,color:yellow,size:54),SizedBox(height:8),Text('ART EXPLORER',style:TextStyle(color:cream,fontSize:22,fontWeight:FontWeight.w900)),Text('Every masterpiece starts with one piece.',style:TextStyle(color:muted,fontSize:12)),
    SizedBox(height:22),Row(children:[_StatValue(value:'12',label:'SOLVED'),_StatValue(value:'3',label:'PERFECT'),_StatValue(value:'6',label:'DAY STREAK')]),
  ])),
  const SizedBox(height:18),const Text('NEXT MILESTONE',style:TextStyle(color:yellow,fontWeight:FontWeight.w900,letterSpacing:1.5)),const SizedBox(height:10),
  Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(18)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('Puzzle Collector',style:TextStyle(color:cream,fontWeight:FontWeight.w900)),SizedBox(height:7),Text('Solve 20 artworks to unlock a special badge.',style:TextStyle(color:muted,fontSize:12)),SizedBox(height:12),ClipRRect(borderRadius:BorderRadius.all(Radius.circular(8)),child:LinearProgressIndicator(value:.6,minHeight:8,backgroundColor:Colors.white10,color:mint)),SizedBox(height:5),Text('12 / 20 artworks',style:TextStyle(color:mint,fontSize:11,fontWeight:FontWeight.w800))])),
])));}
class _StatValue extends StatelessWidget {final String value,label;const _StatValue({required this.value,required this.label});@override Widget build(BuildContext context)=>Expanded(child:Column(children:[Text(value,style:const TextStyle(color:yellow,fontSize:27,fontWeight:FontWeight.w900)),const SizedBox(height:4),Text(label,style:const TextStyle(color:muted,fontSize:9,fontWeight:FontWeight.w900,letterSpacing:.8))]));}
