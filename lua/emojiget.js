// group by pages_name
// 肤色发型性别细节页面下使用
// 组合表情
var cards = document.getElementsByClassName('emoji_card')
var base = "";
for(var i  = 0; i < cards.length; i++){
	base += (
		"yield(Candidate(\"" + 
		document.getElementsByClassName('pages_name capitalize col-auto line')[0].childNodes[1].textContent + 
		"\", seg.start, seg._end, " +
		"\""+cards[i].childNodes[0].text + "\", \"" + cards[i].childNodes[1].text + "\"))") ;
	base += "\n";
}
console.log(base)
// ----------------------------------------------------------------------------
// 全部通用表情
// https://www.emojiall.com/zh-hans/all-emojis
// 已包含 https://www.emojiall.com/zh-hans/categories/A ~ J 的所有表情
// 未包含快捷键设定要求
var out = ""
var cardlist = document.getElementsByClassName('emoji_card_list');
// first 2 not data
for(var i = 2; i< cardlist.length; i++){
	var h2 = cardlist[i].getElementsByTagName('h2');
	var h3 = cardlist[i].getElementsByTagName('h3');
	var gp = cardlist[i].getElementsByClassName('row row-cols-lg-5 row-cols-4 no-gutters list_table');
	var groupName = h2[0].childNodes[0].childNodes[0].textContent + h2[0].childNodes[0].childNodes[1].textContent;
	for(var j = 0; j < h3.length; j++){
		//var subgpName = h3[j].childNodes[0].childNodes[0].textContent + h3[j].childNodes[0].childNodes[1].textContent
		var subgpName = h3[j].childNodes[0].childNodes[1].textContent
		var allGpName = (groupName + '-' + subgpName);
		var g = gp[j];
		if (i == 2 && j == 0)
			out += "if string.match(input, \'/" + subgpName + "\') then\n"
		else
			out += "elseif string.match(input, \'/"  + subgpName + "\') then\n"
		for(var k = 0; k < g.childElementCount; k++){
			var face = g.children[k].children[0].children[0].textContent;
			var cmt  = g.children[k].children[0].children[1].textContent;
			out += "\tyield(Candidate(\"" + allGpName + 
				"\", seg.start, seg._end, \"" +
				face + "\", \"" +
				cmt + "\"))\n";
		}
	}
}
out += "end"
console.log(out)

// source https://www.emojiall.com/zh-hans/all-emojis?type=normal
var out = ""
var cardlist = document.getElementsByClassName('emoji_card_list');
// first 2 not data
var order = 1
var groupOrder = 1
out += "local emoji_candidate_info = {\n"
for(var i = 2; i< cardlist.length; i++){
	var h2 = cardlist[i].getElementsByTagName('h2');
	var h3 = cardlist[i].getElementsByTagName('h3');
	var gp = cardlist[i].getElementsByClassName('row row-cols-lg-5 row-cols-4 no-gutters list_table');
	var groupName = h2[0].childNodes[0].childNodes[0].textContent + h2[0].childNodes[0].childNodes[1].textContent;
	for(var j = 0; j < h3.length; j++){
		//var subgpName = h3[j].childNodes[0].childNodes[0].textContent + h3[j].childNodes[0].childNodes[1].textContent
		var subgpName = h3[j].childNodes[0].childNodes[1].textContent
		var allGpName = (groupName + '-' + subgpName);
		var g = gp[j];
		for(var k = 0; k < g.childElementCount; k++){
			var face = g.children[k].children[0].children[0].textContent;
			var cmt  = g.children[k].children[0].children[1].textContent;
			var gap;
			if (order < 10)
				gap = "      ";
			else if(order < 100)
				gap = "     ";
			else if(order < 1000)
				gap = "    ";
			else
				gap = "   ";

			var gap2;
			if (groupOrder < 10)
				gap2 = "   ";
			else if(groupOrder < 100)
				gap2 = "  ";
			else if(groupOrder < 1000)
				gap2 = " ";
			else
				gap2 = "";

			out += "--[[" + order  + gap + groupOrder + gap2 + "]]\t" + "{" + "cand = \"" + face + "\", comment = \"" + cmt + "\"}," 
			out +=  "\t\t\t--" + subgpName + ",\t" + groupName + "\n"
			order = order + 1
		}
		groupOrder += 1
	}
}
out += "}"
console.log(out)

/*
vim格式化对齐列
将光标放在第一行的任何位置，并在正常模式下通过键入来记录该行的宏：

qa0f=100i <Esc>8|dwjq
转换为：

a-在热键i中记录宏
a-转到行的开头
a-转到第一个等号
a-（在i之后有一个空格，而<Esc>则表示按转义，请不要键入“ <Esc>”。）插入100个空格
a-转到第8列（对不起，您必须手动找出要对齐的列）
a-删除直到下一个非空格字符
a-转到下一行
a-停止记录

*/