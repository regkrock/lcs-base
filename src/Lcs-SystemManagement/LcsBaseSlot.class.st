Class {
	#name : 'LcsBaseSlot',
	#superclass : 'LcsApplicationObject',
	#instVars : [
		'parent',
		'domainClass',
		'properties',
		'comment'
	],
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'querying' }
LcsBaseSlot class >> classNamesPrefixTree [
	^ GtPrefixTree withAll: (self allSubclasses collect: #name)
]

{ #category : 'defaults' }
LcsBaseSlot class >> defaultSlotComment [
	^ ''
]

{ #category : 'testing' }
LcsBaseSlot class >> isAbstract [
	^ self name = #LcsBaseSlot
]

{ #category : 'testing' }
LcsBaseSlot class >> isAccessorSlot [
	^ false
]

{ #category : 'testing' }
LcsBaseSlot class >> isVirtualSlot [
	^ false
]

{ #category : 'gt views' }
LcsBaseSlot >> addOtherSlotDefinitionDetailsTo: collection [
]

{ #category : 'gt views' }
LcsBaseSlot >> addPropertiesTo: collection [
	collection
		add: '' -> '';
		add: '------PROPERTIES------' -> ''.
	collection addAll: self properties associations copy
]

{ #category : 'configuration' }
LcsBaseSlot >> addSlotType: aClass [
	self assert: aClass isClass.
	(self slotTypes includes: aClass) ifFalse: [ self slotTypes add: aClass ]
]

{ #category : 'converting' }
LcsBaseSlot >> asViewItem [
	^ LcsSlotDefinitionViewItem on: self 
]

{ #category : 'configuration' }
LcsBaseSlot >> clearSlotTypes [
	self slotTypes removeAll.
]

{ #category : 'accessing' }
LcsBaseSlot >> comment [
	^ comment
]

{ #category : 'accessing' }
LcsBaseSlot >> comment: anObject [
	comment := anObject
]

{ #category : 'magritte' }
LcsBaseSlot >> commentDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Comment';
		priority: 30;
		accessor: #'comment';
		default: '';
		kind: String;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : 'magritte' }
LcsBaseSlot >> createClassContextMenuContentFor: aClass editor: anElement [
	| theContextMenu items |
	theContextMenu := GtFormContextMenuContent new editorElement: anElement.
	items := OrderedCollection new.
	items
		addAll: {GtCoderContextMenuAction new
					action: [ :form :elem | elem phlow spawnObject: (Smalltalk at: aClass asSymbol) users ];
					title: 'Browse users' asText}.
	theContextMenu items: items.
	^ theContextMenu
]

{ #category : 'initialize' }
LcsBaseSlot >> defaultPriority [
	^ 50
]

{ #category : 'defaults' }
LcsBaseSlot >> defaultSlotComment [
	^ self class defaultSlotComment
]

{ #category : 'slot model' }
LcsBaseSlot >> domainClass [
	^ domainClass ifNil: [ domainClass := self parent ifNotNil: [ :each | each domainClass ] ]
]

{ #category : 'slot model' }
LcsBaseSlot >> domainClass: aDomainClass [
	domainClass := aDomainClass
]

{ #category : 'magritte' }
LcsBaseSlot >> domainClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Domain Class';
		priority: 3;
		accessor: #'domainClass';
		beReadOnly;
		blocShortcuts: [ 
			{BlShortcutWithAction new
				name: 'Browse class';
				description: 'Browses the class indicated by the editor';
				combination: BlKeyCombination primaryB;
				action: [ :anEvent | anEvent target phlow spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
			BlShortcutWithAction new
				name: 'Inspect class';
				description: 'Inspects the class indicated by the editor';
				combination: BlKeyCombination primaryG;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
			BlShortcutWithAction new
				name: 'Browse class references';
				description: 'Browses references to the class indicated by the editor';
				combination: BlKeyCombination primaryN;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ]

]

{ #category : 'properties' }
LcsBaseSlot >> errorPropertyNotFound: aSelector [ 
	LcsSlotPropertyError new
		slotDefinition: self;
		signal: 'Property ' , aSelector , ' not found.'
]

{ #category : 'slot model' }
LcsBaseSlot >> getterSelector [
	| substring1 substring2 |
	substring1 := (self slotName at: 1) asLowercase asString.
	substring2 := self slotName asCamelCase copyFrom: 2 to: self slotName size.
	^ (substring1 , substring2) asSymbol
		
]

{ #category : 'gt views' }
LcsBaseSlot >> gtCreateClassAndValueElementFor: aColumn [
	^ aColumn
		cellStencil: [ BrHorizontalPane new
				hMatchParent;
				vFitContent;
				alignCenter ];
		dataBinder: [ :itemElement :aNode | 
			| nodeIcon |
			LcsBuilderLogger log: 'Item: ' , itemElement printString , '- Node: ' , aNode printString.
			nodeIcon := [ aNode value gtInspectorIcon
					ifNil: [ aNode value class iconNamed: aNode value class systemIconName ] ]
					on: Error
					do: [ :error | Smalltalk ui icons iconNamed: #smallWarningIcon ].
					
			itemElement
				removeChildren;
				addChild: nodeIcon asElement;
				addChild: (BrLabel new
							aptitude: BrGlamorousListLabelAptitude;
							text: aNode value displayString;
							alignCenterLeft;
							hMatchParent;
							vFitContent) ]
]

{ #category : 'gt views' }
LcsBaseSlot >> gtSlotAttributesViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Attributes';
		priority: 5;
		items: [ self gtSlotDefinitionAttributes ];
		column: 'Option' 
			text: #key 
			width: 200;
		column: 'Value' do: [ :aColumn | self gtCreateClassAndValueElementFor: aColumn ];
		send: #value;
		actionUpdateButton;		
		yourself
]

{ #category : 'gt views' }
LcsBaseSlot >> gtSlotDefinitionAttributes [
	| collection |
	collection := OrderedCollection new
			add: 'domainClass' -> self newDomainClassName;
			add: 'slotDefinition' -> self domainClass;
			add: 'pragma' -> self slotPragmaName ;
			add: 'slotDefinitionClass' -> self class;
			yourself.
	self addPropertiesTo: collection.
	self addOtherSlotDefinitionDetailsTo: collection.
	^ collection
]

{ #category : 'gt views' }
LcsBaseSlot >> gtSlotDefinitionMethodViewFor: aView [
	<gtView>

	self domainClass ifNil: [ ^ aView empty ].
	
	^ aView explicit
		title: 'Slot Related Methods';
		priority: 20;
		stencil: [ 
			| methods |
			methods := self domainClass slotDefinitionMethodsNamed: self slotDefinitionSelector.
			self domainClass addInstanceMethodNamed: self getterSelector asSymbol to: methods.
			self isVirtualSlot ifFalse: [
				self domainClass addInstanceMethodNamed: self setterSelector asSymbol to: methods].
			GtPharoMethodsCoder forItems: methods]
]

{ #category : 'gt views' }
LcsBaseSlot >> gtSlotTypesViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Slot Types';
		priority: 10;
		items: [ self slotTypes];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' do: [ :aColumn | 
			aColumn
				cellStencil: [ :eachItem | GtPhlowLabelWithIcon new ];
				dataBinder: [ :aCellElement :eachItem | | icon class label |
					class := eachItem isClass 
								ifTrue: [ eachItem ] 
								ifFalse: [ eachItem class ].
					icon := aCellElement gtSafeIconNamed: class gtSystemIconName.
					label := eachItem isClass 
								ifTrue: [eachItem name asString ] 
								ifFalse: [ eachItem gtDisplayText ].
					aCellElement 
						initializeWithIcon: icon
						label: label ] ];
		yourself

]

{ #category : 'initialize' }
LcsBaseSlot >> initialize [
	super initialize.
	self properties: OrderedDictionary new.
	self slotName: nil.
	self initializeSlotTypes.
	self priority: self defaultPriority.
	self comment: self defaultSlotComment
]

{ #category : 'initialize' }
LcsBaseSlot >> initializeSlotTypes [
	self slotTypes: OrderedCollection new
]

{ #category : 'testing' }
LcsBaseSlot >> isAccessorSlot [
	^ self class isAccessorSlot
]

{ #category : 'testing' }
LcsBaseSlot >> isChangedProperty: aPropertyName value: aValue [
	| propertyValue prepertyAccessor|
	prepertyAccessor := aPropertyName asSymbol.
	(self respondsTo: prepertyAccessor) ifFalse: [ ^ true ].
	propertyValue := self perform: prepertyAccessor.
	(propertyValue class = LcsUpdateActions)
		ifTrue: [ 
			(propertyValue hasNoElements and: [ aValue hasNoElements ])
				ifTrue: [ ^ false ]].
	propertyValue isBlock ifTrue: [
		^ (propertyValue printString = aValue printString) not ].
	^ (propertyValue = aValue) not
]

{ #category : 'testing' }
LcsBaseSlot >> isVirtualSlot [
	^ self class isVirtualSlot
]

{ #category : 'slot model' }
LcsBaseSlot >> label [
	^self labelForSelector: self slotName
]

{ #category : 'slot model' }
LcsBaseSlot >> newDomainClassName [
	^ self domainClass ifNil: [ ^ '<not initialized>']
]

{ #category : 'accessing' }
LcsBaseSlot >> parent [
	^ parent
]

{ #category : 'accessing' }
LcsBaseSlot >> parent: anObject [
	parent := anObject
]

{ #category : 'printing' }
LcsBaseSlot >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self slotName displayString; 
		nextPutAll: ')'
]

{ #category : 'properties' }
LcsBaseSlot >> priority [
	^ self propertyAt: 'priority'
]

{ #category : 'properties' }
LcsBaseSlot >> priority: anObject [
	self propertyAt: 'priority' put: anObject
]

{ #category : 'magritte' }
LcsBaseSlot >> priorityDescription [
	<magritteDescription>
	^ MANumberDescription new
		label: 'Priority';
		priority: 10;
		accessor: #'priority';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired

]

{ #category : 'accessing' }
LcsBaseSlot >> properties [
	^ properties
]

{ #category : 'accessing' }
LcsBaseSlot >> properties: anObject [
	properties := anObject
]

{ #category : 'properties' }
LcsBaseSlot >> propertyAt: aKey [
	"Answer the value of the property ==aKey==, raises an error if the property doesn't exist."

	^ self propertyAt: aKey ifAbsent: [ self errorPropertyNotFound: aKey ]
]

{ #category : 'properties' }
LcsBaseSlot >> propertyAt: aKey ifAbsent: aBlock [
	^ self properties at: aKey ifAbsent: aBlock 
]

{ #category : 'properties' }
LcsBaseSlot >> propertyAt: aKey put: anObject [
	^ self properties at: aKey put: anObject 
]

{ #category : 'configuration' }
LcsBaseSlot >> removeSlotType: aClass [
	self assert: aClass isClass.
	(self slotTypes includes: aClass) ifTrue: [ self slotTypes remove: aClass ]
]

{ #category : 'defaults' }
LcsBaseSlot >> slotClass [
	^ self slotTypes any
]

{ #category : 'magritte' }
LcsBaseSlot >> slotClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Slot Definition Class';
		priority: 2;
		accessor: #'className';
		kind: Object;
		comment: 'The class that this slot is built from';
		blocShortcuts: [ {BlShortcutWithAction new
			name: 'Browse class';
			description: 'Browses the class indicated by the editor';
			combination: BlKeyCombination primaryB;
			action: [ :anEvent | 
				anEvent target phlow
					spawnTool: (GtClassCoderTool forClass: anEvent target text asString asClass) ].
			BlShortcutWithAction new
				name: 'Inspect class';
				description: 'Inspects the class indicated by the editor';
				combination: BlKeyCombination primaryG;
				action: [ :anEvent | anEvent target phlow spawnObject: anEvent target text asString asClass ].
			BlShortcutWithAction new
				name: 'Browse class references';
				description: 'Browses references to the class indicated by the editor';
				combination: BlKeyCombination primaryN;
				action: [ :anEvent | 
					anEvent target phlow
						spawnObject: anEvent target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beReadOnly

]

{ #category : 'asking' }
LcsBaseSlot >> slotDefinitionSelector [
	^ (self slotName asString , 'SlotDefinition') asSymbol
]

{ #category : 'defaults' }
LcsBaseSlot >> slotKind [
	| string |
	string := self slotPragmaName.
	string = 'slotDefinition' ifTrue: [ ^ 'accessor' ].
	^ string copyFrom: 1 to: ((string findString: 'SlotDefinition') - 1)
]

{ #category : 'properties' }
LcsBaseSlot >> slotName [
	^ self propertyAt: 'slotName' ifAbsent: [ ]
]

{ #category : 'properties' }
LcsBaseSlot >> slotName: anObject [
	self propertyAt: 'slotName' put: anObject
]

{ #category : 'magritte' }
LcsBaseSlot >> slotNameDescription [
	<magritteDescription>
	| existingInstvarNames |
	existingInstvarNames := self domainClass ifNil: [ #() ] ifNotNil: [ :c | c allInstVarNames ].
	^ GtMATextDescription new
		label: 'Slot Name';
		priority: 4;
		accessor: #'slotName';
		default: '';
		kind: Object;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
				"+ (BrGlamorousWithExplicitContextMenuAptitude
						itemsWithAnchorActions: [ self contextMenuItemsForSuperclass ])" ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :aValue | aValue asString trim size >= 2 ] labelled: 'Enter a unique slot name of at least two characters in length';
		addCondition: [ :aValue | (existingInstvarNames includes: aValue asString trim asSymbol) not ] labelled: 'Slot already exists';
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		"addCondition: [ :aValue | aValue trim isEmpty  ] labelled: 'Enter a unique slot name of at least two characters in length';"
		beReadOnly;
		beRequired

]

{ #category : 'asking' }
LcsBaseSlot >> slotPragmaName [
	self domainClass ifNil: [ ^ nil ].
	^ (self domainClass pragmaNameOf: self slotDefinitionSelector)
]

{ #category : 'gt views' }
LcsBaseSlot >> slotTypeClassNames [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes do: [ :eachClass |
		stream nextPutAll: (
			eachClass isClass 
				ifTrue: [ eachClass name displayString ] 
				ifFalse: [ eachClass printString ])  ] separatedBy: [ stream nextPutAll: ', '].
	^stream contents
]

{ #category : 'properties' }
LcsBaseSlot >> slotTypes [
	^ self propertyAt: 'slotTypes'
]

{ #category : 'properties' }
LcsBaseSlot >> slotTypes: anObject [
	self propertyAt: 'slotTypes' put: anObject
]

{ #category : 'magritte' }
LcsBaseSlot >> slotTypesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		label: 'Slot Types';
		priority: 30;
		comment: 'Objects that are allowed in this slot must be of these types';
		accessor: (LcsMAPluggableAccessor 
						accessors: #(#slotTypes)
						read: [ :classes | classes collect: [ :each | each name] ] 
						write: [ :aModel :setter :collection | 
							aModel perform: setter with: (collection collect: [ :each | each asClass ] ) ]);
		classes: { Class};
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocListStencil: (
			self
				taggerStencilWithCompletion: GtClassesCompletionStrategy new
				andContextMenuBlock: nil);
		addCondition: [ :aValue | 
				aValue allSatisfy: [ :eachClassName | 
					eachClassName isClass or: [(Smalltalk classOrTraitNamed: eachClassName asString trim) isNotNil ] ] ]
			labelled: 'Unknown Class(s)';
		addCondition: [ :aValue | aValue asSet size = aValue size ]
			labelled: 'Duplicate classes are not allowed';
		beRequired
]

{ #category : 'printing' }
LcsBaseSlot >> slotTypesList [
	| stream |
	stream := WriteStream on: String new.
	self slotTypes 
		do: [ :each | stream nextPutAll: each name ] 
		separatedBy: [stream nextPutAll: ', ' ].
	^ stream contents
]

{ #category : 'slot model' }
LcsBaseSlot >> slotVarPut: anObject in: aDomainObject [
	^ LcsError signal: 'Attempt to update a read only slot'
]

{ #category : 'magritte' }
LcsBaseSlot >> taggerStencilWithCompletion: aCompletionStrategy andContextMenuBlock: aContextMenuBlock [
	^ [ :aMemento :aDescription :aForm | 
	| aTagger aTaggerAptitude |
	aTagger := BrTagger new hFitContentLimited.
	aForm hMatchParent.
	aTagger
		padding: (BlInsets top: -2 bottom: 5);
		clipChildren: false;
		aptitude: (aTaggerAptitude := GtCreationEditableTaggerAptitude new
					margin: (BlInsets
							top: 0
							bottom: 3
							left: 0
							right: 5);
					tagLabel: [ :aTag | 
						| aLabel |
						aLabel := BrEditor new fitContent
								text: (aDescription displayStringFor: aTag name);
								aptitude: (BrGlamorousEditableLabelAptitude new glamorousFormEditorCodeFontAndSize
										defaultForeground: Color black);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to previous form item';
										description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
										combination: BlKeyCombination shiftTab;
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionBackward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]);
								addShortcut: (BlShortcutWithAction new
										name: 'Move to next form item';
										description: 'Moves to the next form item. If none is found, we cycle back to the first.';
										combination: (BlKeyCombination tab or: BlKeyCombination enter);
										action: [ :anEvent | 
											BlFocusFinder new
												direction: BlFocusSearchDirectionForward new;
												root: aForm;
												referenceElement: anEvent currentTarget;
												nextFocusDo: #requestFocus ifNone: [  ] ]).

						aDescription blocShortcuts
							ifNotNil: [ :aBlockReturningCollection | 
								aBlockReturningCollection value
									do: [ :aShortcut | aLabel addShortcut: aShortcut ] ].

						aCompletionStrategy
							ifNotNil: [ (GtCompletionController on: aLabel strategy: aCompletionStrategy) install ].
						aContextMenuBlock
							ifNotNil: [ aLabel
									addAptitude: (BrGlamorousWithExplicitContextMenuAptitude
											content: [ aContextMenuBlock
													value: aTag name
													value: aLabel
													value: aMemento ]) ].
						aLabel ]).
	aTagger
		when: BrTaggerAddTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget addTag: aRequest tag.
			aValue := aTagger tags collect: #name thenSelect: #isNotEmpty.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		when: BrTaggerRenameTagRequest
		do: [ :aRequest | 
			(aRequest tag name = aRequest newName) not
				ifTrue: [ | aValue |
					aRequest currentTarget renameTag: aRequest tag to: aRequest newName.
					aValue := aTagger tags collect: #name.

					GtMagritteBuilderUtility
						write: aValue asArray
						using: aDescription
						memento: aMemento
						element: aTagger ] ].
	aTagger
		when: BrTaggerRemoveTagRequest
		do: [ :aRequest | 
			| aValue |
			aRequest currentTarget removeTag: aRequest tag.
			aValue := aTagger tags collect: #name.

			GtMagritteBuilderUtility
				write: aValue asArray
				using: aDescription
				memento: aMemento
				element: aTagger ].
	aTagger
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theTagger :aSink | 
					| theValues |
					(theTagger tags isEmpty or: [ aSink value isChanged not ])
						ifTrue: [ theValues := aSink value currentValue.
							theTagger namedTags: theValues ] ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].
	GtMagritteBuilderUtility
		newValidationContainerWith: aTagger
		memento: aMemento
		using: aDescription ]

]
