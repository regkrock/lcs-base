Class {
	#name : #GtBehaviorCreationForm,
	#superclass : #GtCreationForm,
	#instVars : [
		'traits',
		'slots',
		'newClassName',
		'classSlots'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtBehaviorCreationForm class >> componentName [
	^ self subclassResponsibility
]

{ #category : #accessing }
GtBehaviorCreationForm class >> priority [
	^ 2
]

{ #category : #accessing }
GtBehaviorCreationForm >> classSlots [
	^ classSlots
]

{ #category : #accessing }
GtBehaviorCreationForm >> classSlots: arg1 [
	classSlots := arg1
]

{ #category : #accessing }
GtBehaviorCreationForm >> classSlotsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAToManyRelationDescription new.
	tmp2
		label: 'Class Slots';
		priority: 10;
		accessor: #classSlots;
		classes: {String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil).
	^ tmp2
		addCondition: [ :arg1 | arg1 asSet size = arg1 size ]
		labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtBehaviorCreationForm >> createTraitsContextMenuContentFor: arg1 editor: arg2 [
	| tmp1 tmp2 tmp4 |
	tmp1 := GtFormContextMenuContent new editorElement: arg2.
	tmp2 := OrderedCollection new.
	tmp4 := GtCoderContextMenuAction new.
	tmp4
		action: [ :arg3 :arg4 | arg4 phlow spawnObject: (Smalltalk at: arg1 asSymbol) users ].
	tmp2 addAll: {tmp4 title: 'Browse users' asText}.
	tmp1 items: tmp2.
	^ tmp1
]

{ #category : #initialization }
GtBehaviorCreationForm >> initialize [
	super initialize.
	self newClassName: ''.
	traits := OrderedCollection new.
	slots := OrderedCollection new.
	classSlots := OrderedCollection new
]

{ #category : #accessing }
GtBehaviorCreationForm >> installClassSlotsOn: arg1 [
	| tmp1 tmp3 |
	classSlots isEmpty ifTrue: [ ^ self ].
	tmp1 := classSlots
			collect: [ :arg2 | RBAddInstanceVariableChange add: arg2 to: arg1 classSide ].
	tmp3 := RBCompositeRefactoryChange new.
	tmp3
		name: 'Add class slots';
		changes: tmp1.
	tmp3 yourself gtExecuteWithUndo
]

{ #category : #magritte }
GtBehaviorCreationForm >> nameDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := GtMATextDescription new.
	tmp2
		label: 'Name';
		beRequired;
		priority: 1;
		accessor: #newClassName;
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :arg1 | arg1 asString trim isNotEmpty ]
			labelled: 'Name cannot be empty';
		addCondition: [ :arg2 | (Smalltalk classNamed: arg2 asString trim) isNil ]
			labelled: 'Name is already taken';
		addCondition: [ :arg3 | arg3 size > 0 ifTrue: [ arg3 first isUppercase ] ifFalse: [ true ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :arg4 | arg4 asString allSatisfy: [ :arg5 | arg5 isAlphaNumeric or: [ arg5 = $_ ] ] ]
			labelled: 'Name must be alphanumeric'.
	^ tmp2
		addCondition: [ :arg6 | (arg6 = 'TNameOfTrait') not and: [ (arg6 = 'NameOfSubclass') not ] ]
		labelled: 'Name cannot be example value'
]

{ #category : #accessing }
GtBehaviorCreationForm >> newClassName [
	^ newClassName asRopedText attribute: (self ghostTextFor: self defaultName)
]

{ #category : #accessing }
GtBehaviorCreationForm >> newClassName: arg1 [
	newClassName := arg1 asString
]

{ #category : #accessing }
GtBehaviorCreationForm >> rawClassName [
	^ newClassName asString
]

{ #category : #accessing }
GtBehaviorCreationForm >> slots [
	^ slots
]

{ #category : #accessing }
GtBehaviorCreationForm >> slots: arg1 [
	slots := arg1
]

{ #category : #accessing }
GtBehaviorCreationForm >> slotsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAToManyRelationDescription new.
	tmp2
		label: 'Slots';
		priority: 5;
		accessor: #slots;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		classes: {String};
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil).
	^ tmp2
		addCondition: [ :arg1 | arg1 asSet size = arg1 size ]
		labelled: 'All slot names must be unique'
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitClassesOrNils [
	<return: #Collection of: #Trait>
	^ self traitClassesOrNilsFor: self traits
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitClassesOrNilsFor: arg1 [
	<return: #Collection of: #Trait>
	^ arg1 collect: [ :arg2 | Smalltalk classOrTraitNamed: arg2 asString trimBoth ]
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitComposition [
	^ self traitCompositionFor: self traitClassesOrNils
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitCompositionFor: arg1 [
	^ (arg1 reject: #isNil) asArray asTraitComposition
]

{ #category : #accessing }
GtBehaviorCreationForm >> traits [
	<return: #Collection of: #String>
	^ traits
]

{ #category : #accessing }
GtBehaviorCreationForm >> traits: arg1 [
	traits := arg1
]

{ #category : #accessing }
GtBehaviorCreationForm >> traitsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAToManyRelationDescription new.
	tmp2
		label: 'Traits';
		priority: 6;
		accessor: #traits;
		classes: {String};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (self
					taggerStencilWithCompletion: GtClassesCompletionStrategy new
					andContextMenuBlock: [ :arg1 :arg2 :arg3 | 
						arg3 overallStatus valueOrNil isChanged
							ifTrue: [ GtCoderContextMenuContent new editorElement: arg2 ]
							ifFalse: [ self createTraitsContextMenuContentFor: arg1 editor: arg2 ] ]);
		blocShortcuts: [ | tmp4 tmp6 tmp8 |
				tmp4 := BlShortcutWithAction new.
				tmp4
					name: 'Browse trait';
					description: 'Browses the trait indicated by the editor';
					combination: BlKeyCombination primaryB.
				tmp6 := BlShortcutWithAction new.
				tmp6
					name: 'Inspect trait';
					description: 'Inspects the trait indicated by the editor';
					combination: BlKeyCombination primaryG.
				tmp8 := BlShortcutWithAction new.
				tmp8
					name: 'Browse trait references';
					description: 'Browses references to the trait indicated by the editor';
					combination: BlKeyCombination primaryN.
				{tmp4
						action: [ :arg4 | 
							arg4 target phlow
								spawnTool: (GtClassCoderTool forClass: arg4 target text asString asClass) ].
					tmp6
						action: [ :arg5 | arg5 target phlow spawnObject: arg5 target text asString asClass ].
					tmp8
						action: [ :arg6 | arg6 target phlow spawnObject: arg6 target text asString asClass gtReferences ]} ];
		addCondition: [ :arg7 | arg7 asSet size = arg7 size ]
			labelled: 'All Trait names must be unique';
		addCondition: [ :arg8 | 
					arg8
						allSatisfy: [ :arg9 | (Smalltalk classOrTraitNamed: arg9 asString trim) isNotNil ] ]
			labelled: 'Unknown Trait(s)';
		addCondition: [ :arg10 | 
					| tmp9 |
					tmp9 := self traitClassesOrNilsFor: arg10.
					tmp9 allSatisfy: [ :arg11 | arg11 isNil or: [ arg11 isTrait ] ] ]
			labelled: 'Only Traits are allowed'.
	^ tmp2
		addCondition: [ :arg12 | 
			| tmp10 tmp11 |
			arg12 size > 1
				ifTrue: [ tmp10 := self traitClassesOrNilsFor: arg12.
					((tmp10 allSatisfy: #isNotNil) and: [ tmp10 size = tmp10 asSet size ])
						ifTrue: [ tmp11 := self traitCompositionFor: tmp10.
							tmp11 methods
								allSatisfy: [ :arg13 | (tmp11 isConflictingSelector: arg13 selector) not ] ]
						ifFalse: [ true ] ]
				ifFalse: [ true ] ]
		labelled: 'Conflicting Traits'
]
