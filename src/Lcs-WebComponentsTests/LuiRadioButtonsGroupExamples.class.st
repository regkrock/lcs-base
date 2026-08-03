Class {
	#name : 'LuiRadioButtonsGroupExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'private' }
LuiRadioButtonsGroupExamples >> expectedRadioButtonsGroupHtml [
	^ '<div id="259040590" data-name="mainSkill" data-StClass="LuiRadioButtonsGroup" class="radioButtons"><input id="231379389" data-name="mainSkill_1" data-StClass="LuiRadioButton" name="mainSkill" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;1&quot;,&quot;2=&quot;+encodeURIComponent($(&quot;#231379389&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;3&quot;)}})" value="1" type="radio"/><label id="186571932" data-name="mainSkill_1_label" data-StClass="LuiLabel" for="231379389">Skill 1</label><input id="233043914" data-name="mainSkill_2" data-StClass="LuiRadioButton" name="mainSkill" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;4&quot;,&quot;5=&quot;+encodeURIComponent($(&quot;#233043914&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;6&quot;)}})" value="2" type="radio"/><label id="158813697" data-name="mainSkill_2_label" data-StClass="LuiLabel" for="233043914">Skill 2</label><input id="234708439" data-name="mainSkill_3" data-StClass="LuiRadioButton" name="mainSkill" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;7&quot;,&quot;8=&quot;+encodeURIComponent($(&quot;#234708439&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;9&quot;)}})" value="3" type="radio"/><label id="131055462" data-name="mainSkill_3_label" data-StClass="LuiLabel" for="234708439">Skill 3</label><input id="236372964" data-name="mainSkill_4" data-StClass="LuiRadioButton" name="mainSkill" onchange="$.ajax({&quot;url&quot;:&quot;/&quot;,&quot;data&quot;:[&quot;10&quot;,&quot;11=&quot;+encodeURIComponent($(&quot;#236372964&quot;).val())].join(&quot;&amp;&quot;),&quot;success&quot;:function(){$(&quot;#nil&quot;).load(&quot;/&quot;,&quot;12&quot;)}})" checked value="unknown" type="radio"/><label id="103297227" data-name="mainSkill_4_label" data-StClass="LuiLabel" for="236372964">unknown</label></div>'
]

{ #category : 'examples' }
LuiRadioButtonsGroupExamples >> mainSkillsRadioButtonsGroupFirstRadioButton [
	<gtExample>
	<after: #clearUnitOfWork>
	| radioButtonsGroup radioButton |
	radioButtonsGroup := self wrappedMainSkillsRadioButtonsGroup.
	radioButton := radioButtonsGroup orderedComponents at: 1.
	self assert: radioButton componentName = 'mainSkill_1'.
	self assert: radioButton dependentComponents size = 1.
	self assert: radioButton dependentComponents first equals: radioButtonsGroup.
	self assert: radioButton text equals: '1'.
	self assert: radioButton model equals: (radioButtonsGroup elements at: 1).
	self deny: radioButton isSelected.
	radioButton handleCallbackValue: '1'.
	self assert: radioButton isSelected.
	^ radioButton
]

{ #category : 'examples' }
LuiRadioButtonsGroupExamples >> mainSkillsRadioButtonsGroupFirstRadioButtonWithAnAdditionalDependentComponent [
	<gtExample>
	<after: #clearUnitOfWork>
	| radioButtonsGroup component mainSkillSelectComponent person wrapper |
	radioButtonsGroup := self wrappedMainSkillsRadioButtonsGroup.
	person := radioButtonsGroup model.
	mainSkillSelectComponent := LuiSelect onSlot: (person slotDefinitionNamed: 'mainSkill') model: person.
	wrapper := LuiLabelWithInputComponent new.
	wrapper addComponent: mainSkillSelectComponent.
	radioButtonsGroup addDependentComponent: mainSkillSelectComponent.
	component := radioButtonsGroup orderedComponents at: 1.
	self assert: component dependentComponents size = 2.
	self assert: component dependentComponents first equals: component parentComponent.
	self assert: (component dependentComponents at: 2) equals: mainSkillSelectComponent.
	^ component
]

{ #category : 'examples' }
LuiRadioButtonsGroupExamples >> mainSkillsRadioButtonsGroupFourthRadioButton [
	<gtExample>
	<after: #clearUnitOfWork>
	| radioButtonsGroup radioButton |
	radioButtonsGroup := self wrappedMainSkillsRadioButtonsGroup.
	radioButton := radioButtonsGroup orderedComponents at: 7.
	self assert: radioButton componentName = 'mainSkill_4'.
	self assert: radioButton dependentComponents size = 1.
	self assert: radioButton dependentComponents first equals: radioButtonsGroup.
	self assert: radioButton text equals: 'unknown'.
	self assert: radioButton model equals: (radioButtonsGroup elements at: 4).
	self assert: radioButton isSelected.
	^ radioButton
]

{ #category : 'examples' }
LuiRadioButtonsGroupExamples >> mainSkillsRadioButtonsGroupSecondRadioButton [
	<gtExample>
	<after: #clearUnitOfWork>
	| radioButtonsGroup radioButton |
	radioButtonsGroup := self wrappedMainSkillsRadioButtonsGroup.
	radioButton := radioButtonsGroup orderedComponents at: 3.
	self assert: radioButton componentName = 'mainSkill_2'.
	self assert: radioButton dependentComponents size = 1.
	self assert: radioButton dependentComponents first equals: radioButtonsGroup.
	self assert: radioButton text equals: '2'.
	self assert: radioButton model equals: (radioButtonsGroup elements at: 2).
	self deny: radioButton isSelected.
	radioButton handleCallbackValue: '2'.
	self assert: radioButton isSelected.
	^ radioButton
]

{ #category : 'examples' }
LuiRadioButtonsGroupExamples >> mainSkillsRadioButtonsGroupThirdRadioButton [
	<gtExample>
	<after: #clearUnitOfWork>
	| radioButtonsGroup radioButton |
	radioButtonsGroup := self wrappedMainSkillsRadioButtonsGroup.
	radioButton := radioButtonsGroup orderedComponents at: 5.
	self assert: radioButton componentName = 'mainSkill_3'.
	self assert: radioButton dependentComponents size = 1.
	self assert: radioButton dependentComponents first equals: radioButtonsGroup.
	self assert: radioButton text equals: '3'.
	self assert: radioButton model equals: (radioButtonsGroup elements at: 3).
	self deny: radioButton isSelected.
	radioButton handleCallbackValue: '3'.
	self assert: radioButton isSelected.
	^ radioButton
]

{ #category : 'examples' }
LuiRadioButtonsGroupExamples >> mainSkillsRadioGroup [
	<gtExample>
	<after: #clearUnitOfWork>
	| component person |
	
	self ensureCurrentSystemIsPrototypeSystem.
	person := LxxPerson new.
	component := (LuiRadioButtonsGroup 
			onSlotNamed: 'mainSkill' 
			model: person).
	self assert: component componentName equals: 'mainSkill'.
	self assert: component selected skillCode equals: 'unknown'.
	self assert: component parentComponent isNil.
	self assert: component cssClassesString equals: 'radioButtons'.
	^ component
]

{ #category : 'examples' }
LuiRadioButtonsGroupExamples >> wrappedMainSkillsRadioButtonsGroup [
	<gtExample>
	<after: #clearUnitOfWork>
	| component wrapper |
	wrapper := LuiLabelWithInputComponent new.
	component := self mainSkillsRadioGroup.
	wrapper addComponent: component.
	self assert: component components size equals: 8. 
	1 to: 8 by: 2 do: [ :index | | radioButtonComponent labelComponent |
		radioButtonComponent := component orderedComponents at: index.
		labelComponent := component orderedComponents at: (index + 1).
		self assert: radioButtonComponent parentComponent equals: component.
		self assert: labelComponent parentComponent equals: component.
		self assert: labelComponent for equals: radioButtonComponent componentId ].
	self assertRendered: component equals: self expectedRadioButtonsGroupHtml.
	^ component
]
