@tool
extends PopochiuDialog

var first_time 			: bool = true
var asked_abt_husband 	: bool = false
var asked_abt_children 	: bool = false
var asked_abt_cockatoo 	: bool = false
var watched_browsing 	: bool = false
var ignore_click		: bool = false

#region Virtual ####################################################################################
func _on_start() -> void:
	if ignore_click: return
	# One can put here something to excecute before showing the dialog options.
	# E.g. Make the PC to look at the character which it will talk to, walk to
	# it, and say something (or make the character say something):
	
	#await E.play_transition(PopochiuTransitionLayer.FADE_IN, 5)
	#var canv = E.find_child("TransitionsLayer") as CanvasLayer
	#canv.layer = 9
	#await E.wait(5)
	#await E.play_transition(PopochiuTransitionLayer.PASS_DOWN_OUT, 1)
	
	#await ignore_click_while(func():
		#await fade_in()
		#await E.wait(3)
		#await fade_out()
	#)
	
	await C.player.face_clicked()
	await C.WorkingClassWoman.say("[wave]♫ Hmm-hmm-hmm ♪[/wave]")


	if (first_time):
		update_dialog([
			opt("agoodone", "A good one? Point at the book"),
			opt("hello",    "Hello"),
			opt("leave",    "[Leave]")
		])
	else:
		update_dialog([
			opt("husbandmissing", 	"Maybe your husband missing?"),
			opt("childrenmissing", 	"Maybe your children are missing?"),
			opt("cockatoomissing", 	"Maybe your *cockatoo* is missing?"),
			opt("watchbrowse", 		"Watch her browse books"),
		])
	
	# (!) It MUST always use an await
	await E.get_tree().process_frame


func update_dialog(array: Array[PopochiuDialogOption]) -> void:
	var RES = load("res://game/dialogs/working_class_woman_first/dialog_working_class_woman_first.tres")
	RES.options.clear()
	RES.options.append_array(array)
	#var res = load("res://game/dialogs/working_class_woman_first/dialog_working_class_woman_first.tres")
	#print(res.options.size())


func opt(id: String, text: String, visible: bool = true) -> PopochiuDialogOption:
	var opt = PopochiuDialogOption.new()
	opt.id = id
	opt.text = text
	opt.visible = visible
	return opt


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"agoodone":
			await C.WorkingClassWoman.say("Yes, hello")
			update_dialog([
				opt("whoareyou", "Who are you?")
			])
		"hello":
			await C.WorkingClassWoman.say("Hello")
			update_dialog([
				opt("whoareyou", "Who are you?")
			])
		"whoareyou":
			await C.WorkingClassWoman.say("Me? No one")
			await C.WorkingClassWoman.say("I'm just a working class woman")
			update_dialog([
				opt("shouldwork", "Shouldn't a working class woman be working?"),
				opt("whatdoing",  "What are you doing?"),
				opt("leave",      "Have a good day Leave")
			])
		"shouldwork":
			await C.WorkingClassWoman.say("Not all the time")
			await C.WorkingClassWoman.say("Right now I'm browsing books")
			await C.WorkingClassWoman.say("Even a working class need something to read")
			update_dialog([
				#opt("phenomenal", "Phenomenal"),
				opt("goodgood",   "Good, good"),
				opt("policeman",  "I'm a policeman")
			])
		"whatdoing":
			await C.WorkingClassWoman.say("Just reading a book")
			update_dialog([
				opt("goodgood",   "Good, good"),
				opt("policeman",  "I'm a policeman")
			])
		"goodgood":
			await C.WorkingClassWoman.say("It is")
			update_dialog([
				opt("policeman",  "I'm a policeman")
			])
		"policeman":
			await C.WorkingClassWoman.say("I know you are")
			update_dialog([
				opt("goodthen", "Good then"),
				opt("help", "Do you need the help of a policeman?"),
			])
		"goodthen":
			await C.WorkingClassWoman.say("Mhm")
			update_dialog([
				opt("help", "Do you need the help of a policeman?"),
			])
		"help":
			first_time = false
			await C.WorkingClassWoman.say("What with?")
			update_dialog([
				opt("husbandmissing", "Maybe your husband missing?"),
				opt("watchbrowse", "Watch her browse the books"),
			])
		"husbandmissing":
			await C.WorkingClassWoman.say("My husband? No he's not")
			update_dialog([
				opt("where", "So where could he be?"),
			])
		"where":
			await C.WorkingClassWoman.say("I don't know, at home right now?")
			await C.WorkingClassWoman.say("Out drinking with friends?")
			await C.WorkingClassWoman.say("Working?")
			update_dialog([
				opt("youdontknow", "So what I'm hearing is: you don't really know where your husband is?"),
			])
		"youdontknow":
			await C.WorkingClassWoman.say("Yes, but...")
			await C.WorkingClassWoman.say("I don't really need to know where my husband is")
			await C.WorkingClassWoman.say("Not all the time")
			update_dialog([
				opt("wouldntyouliketo", "Wouldn't you like to?"),
			])
		"wouldntyouliketo":
			await C.WorkingClassWoman.say("No")
			update_dialog([
				opt("icantotallyhelp", "I can totally help you find your missing husband"),
				opt("idontcare", "Suit yourself then. I don't really care if you husband is missing"),
				opt("youarerightisntmissing", "Maybe you're right. Maybe he isn't missing"),
			])
		"icantotallyhelp":
			asked_abt_husband = true
			await C.WorkingClassWoman.say("Why are we still talking about this?")
			await C.WorkingClassWoman.say("I haven't lost my husband")
			update_dialog([
				opt("childrenmissing", "Maybe your children are missing?"),
				opt("cockatoomissing", "Maybe your *cockatoo* is missing?"),
				opt("watchbrowse", "Watch her browse books"),
			])
		"idontcare":
			await C.WorkingClassWoman.say("Uh... Okay")
			update_dialog([
				opt("icantotallyhelp", "I can totally help you find your missing husband"),
				opt("youarerightisntmissing", "Maybe you're right. Maybe he isn't missing"),
			])
		"youarerightisntmissing":
			await C.WorkingClassWoman.say("He's definetely not missing, sir")
			update_dialog([
				opt("icantotallyhelp", "I can totally help you find your missing husband"),
			])
		"childrenmissing":
			await C.WorkingClassWoman.say("No, absolutely not")
			update_dialog([
				opt("wherechildren", "Okay, where are they?"),
			])
		"wherechildren":
			await C.WorkingClassWoman.say("Are you a policeman or nanny?")
			update_dialog([
				opt("wherechildrennanny", "Nanny. Where are they?"),
				opt("wherechildrenpolice", "I police whatever I want. Where are they?"),
			])
		"wherechildrennanny":
			await C.WorkingClassWoman.say("They are not missing")
			update_dialog([
				opt("cigarettes", "They are at home, right? Smoking cigarettes"),
			])
		"wherechildrenpolice":
			await C.WorkingClassWoman.say("They are not missing, sir")
			update_dialog([
				opt("cigarettes", "They are at home, right? Smoking cigarettes"),
			])
		"cigarettes":
			await C.WorkingClassWoman.say("What? That's just--")
			await C.WorkingClassWoman.say("My daughters are perfectly *fine*")
			await C.WorkingClassWoman.say("They're with their friends down in Jamrock!")
			await C.WorkingClassWoman.say("There's *nothing* to worry about")
			await C.WorkingClassWoman.say("They're almost grown up now anyway")
			await C.WorkingClassWoman.say("They're past the age they need me protecting them from everything now")
			update_dialog([
				opt("tellage", "I'm afraid the danger is now greater than ever. Tell me, how old are they?"),
			])
		"tellage":
			await C.WorkingClassWoman.say("My youngest girl, Jolie, is just shy of sixteen")
			await C.WorkingClassWoman.say("Jennie is turning eighteen next month")
			await C.WorkingClassWoman.say("But we shouldn't even be talking about them!")
			update_dialog([
				opt("appearance", "And can you describe me their appearance? Any features that stand out, something to make identifying a little easier?"),
			])
		"appearance":
			await C.WorkingClassWoman.say("Why do you need to know this?")
			await C.WorkingClassWoman.say("Heaven't I repeatedly told you they are not missing?")
			await C.WorkingClassWoman.say("That they're in Jamrock, safe and well, at some stupid party?")
			update_dialog([
				opt("timtryingtobeprofessional", "It's for the investigation. I'm trying to be progessional."),
			])
		"timtryingtobeprofessional":
			asked_abt_children = true
			await C.WorkingClassWoman.say("There's no *investigation* here, I can tell you that!")
			update_dialog([
				opt("cockatoomissing", "Maybe your *cockatoo* is missing?"),
				opt("watchbrowse", "Watch her browse books"),
			])
		"cockatoomissing":
			asked_abt_cockatoo = true
			await C.WorkingClassWoman.say("I don't mean to disrespect, sir, but *you* are being a bit of cocatoo here")
			update_dialog([
				opt("askingcockatoo", "Ma'am, I was asking about your cockatoo. Is it missing?"),
				opt("wdymcockatoo", "What do you mean I'm being a cockatoo?"),	#todo
			])
		"askingcockatoo":
			await C.WorkingClassWoman.say("I don't even have a cockatoo. And guess what?")
			update_dialog([
				opt("what", "What?"),
				opt("cockatoonotmissing", "All right, cockatoo not missing. I just wanted to make sure.")
			])
		"what":
			await C.WorkingClassWoman.say("Even if I had, it wouldn't be missing")
			update_dialog([
				opt("cockatoonotmissing", "All right, cockatoo not missing. I just wanted to make sure.")
			])
		"cockatoonotmissing":
			await C.WorkingClassWoman.say("Great")
			update_dialog([
				opt("wdymcockatoo", "Just one more question: what did you mean by me being a cockatoo?"),
			])
		"wdymcockatoo":
			await C.WorkingClassWoman.say("Nothing")
			await C.WorkingClassWoman.say("Go read up on them if you're so interested")
			await C.WorkingClassWoman.say("There's a great book in the bookstore")
			update_dialog([
				opt("gonnaread", "Actually, that's exactly what I'm going to do, thanks for the tip."),
			])
		"gonnaread":
			await C.WorkingClassWoman.say("Wonderfull, the store is open")
			update_dialog([
				opt("watchbrowse", "Watch her browse the books"),
				opt("leave", "That's all for a moment. I'll let you read [Leave]")
			])
		"watchbrowse":
			watched_browsing = true
			await C.WorkingClassWoman.say("...")
			var arr : Array[PopochiuDialogOption] = []
			if (asked_abt_husband and asked_abt_children and asked_abt_cockatoo and watched_browsing):
				arr.append(opt("hug", "Give her a hug"))
			arr.append(opt("leave", "That's all for a moment. I'll let you read [Leave]"))
			update_dialog(arr)
		"hug":
			#come to the woman
			#black screen
			await ignore_click_while(func():
				await fade_in()
			)
			await C.WorkingClassWoman.say("What is happening?")
			await C.WorkingClassWoman.say("...")
			await C.WorkingClassWoman.say("Uh... What are you doing, officer?")
			update_dialog([
				opt("fightingforworkingclass", "I am fighting for the working class"),
				opt("iamhugmonster", "Hey, I hug whomever I please! I'm a hug monster"),
			])
		"fightingforworkingclass":
			await C.WorkingClassWoman.say("Fighting for it how?")
			update_dialog([
				opt("onehugattime", "One hug at time"),
				opt("ahugaday", "A hug a day keeps the bourgeoisie away"),
				opt("hugbyhug", "Hug-by-Hug"),
			])
		"onehugattime", "ahugaday", "hugbyhug":
			await C.WorkingClassWoman.say("Oh...")
			await C.WorkingClassWoman.say("I guess it's better then nothing")
			await C.WorkingClassWoman.say("Keep fighting on, my fellow comrade")
			update_dialog([
				opt("stophug", "...")
			])
		"iamhugmonster":
			await C.WorkingClassWoman.say("A hug monster?")
			await C.WorkingClassWoman.say("How do these two go hand-in-hand?")
			update_dialog([
				opt("stophug", "They dont't. I just forced them this way. That's why I am a monster."),
				opt("stophug", "Well, you're not actually entitled to another person's body. Hugging can be considered a rather monstrous thing to do."),
			])
		"stophug":
			#black screen vanishes
			await ignore_click_while(func():
				await fade_out()
			)
			await C.WorkingClassWoman.say("Right, uh...")
			update_dialog([
				opt("leave", "That's all for a moment. I'll let you read [Leave]")
			])
		
		#should be always below
		"leave", _:
			stop()
	
	#old_thing(opt)
	_show_options()


func turn_off_opts_all():
	for opt in options:
		if opt.visible:
			opt.turn_off()
	pass


func fade_in() -> void:
	var canv = E.find_child("TransitionsLayer") as CanvasLayer
	canv.layer = 9
	await E.play_transition(PopochiuTransitionLayer.FADE_IN, 1)


func fade_out() -> void:
	var canv = E.find_child("TransitionsLayer") as CanvasLayer
	canv.layer = 10
	await E.play_transition(PopochiuTransitionLayer.FADE_OUT, 1)


func ignore_click_while(action : Callable):
	ignore_click = true
	await action.call()
	ignore_click = false


# Use this to save custom data for this PopochiuDialog when saving the game.
# The Dictionary must contain only JSON supported types: bool, int, float, String.
func _on_save() -> Dictionary:
	return {}


# Called when the game is loaded.
# This Dictionary should has the same structure you defined for the returned one in _on_save().
func _on_load(data: Dictionary) -> void:
	prints(data)


#endregion
