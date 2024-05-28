Class {
	#name : #GtClassCreationForm,
	#superclass : #GtBehaviorCreationForm,
	#instVars : [
		'superclassName',
		'classVars',
		'pools'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #accessing }
GtClassCreationForm class >> componentName [
	^ 'Class'
]

{ #category : #accessing }
GtClassCreationForm class >> priority [
	^ 1
]

{ #category : #accessing }
GtClassCreationForm >> classDefinitionString [
	^ String
		streamContents: [ :arg1 | 
			arg1 << self superclassName << ' subclass: '
				<< self rawClassName asSymbol storeString.
			self traits ifNotEmpty: [ arg1 << ' uses: ' << (' + ' join: self traits) ].
			arg1 << ' instanceVariableNames: ' << (' ' join: self slots) storeString
				<< ' classVariableNames: ' << (' ' join: self classVars) storeString
				<< ' poolDictionaries: ' << (' ' join: self pools) storeString
				<< ' package: ' << self commitPackage categoryName asString storeString ]
]

{ #category : #accessing }
GtClassCreationForm >> classVars [
	^ classVars
]

{ #category : #accessing }
GtClassCreationForm >> classVars: arg1 [
	classVars := arg1
]

{ #category : #accessing }
GtClassCreationForm >> classVarsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAToManyRelationDescription new.
	tmp2
		label: 'Class vars';
		priority: 7;
		accessor: #classVars;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		classes: {String}.
	^ tmp2
		blocListStencil: (self taggerStencilWithCompletion: nil andContextMenuBlock: nil)
]

{ #category : #accessing }
GtClassCreationForm >> commit [
	| tmp1 |
	self defineClass.
	tmp1 := Smalltalk classNamed: self rawClassName.
	self installClassSlotsOn: tmp1.
	^ tmp1
]

{ #category : #accessing }
GtClassCreationForm >> contextMenuItemsForSuperclass [
	^ {'Browse references'
			-> [ :arg1 | arg1 phlow spawnObject: arg1 text asString asClass gtReferences ]}
]

{ #category : #accessing }
GtClassCreationForm >> defaultName [
	^ 'NameOfSubclass'
]

{ #category : #accessing }
GtClassCreationForm >> defineClass [
	(GtRBAddClassWithSlotsChange definition: self classDefinitionString)
		gtExecuteWithUndo
]

{ #category : #accessing }
GtClassCreationForm >> initialize [
	super initialize.
	self superclassName: 'Object'.
	classVars := OrderedCollection new.
	pools := OrderedCollection new
]

{ #category : #accessing }
GtClassCreationForm >> pools [
	^ pools
]

{ #category : #accessing }
GtClassCreationForm >> pools: arg1 [
	pools := arg1
]

{ #category : #accessing }
GtClassCreationForm >> poolsDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAToManyRelationDescription new.
	tmp2
		label: 'Pools';
		priority: 7;
		accessor: #pools;
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		classes: {String}.
	^ tmp2
		blocListStencil: (self
				taggerStencilWithCompletion: GtPoolsCompletionStrategy new
				andContextMenuBlock: nil)
]

{ #category : #accessing }
GtClassCreationForm >> superclassDescription [
	<magritteDescription>
	| tmp2 |
	tmp2 := MAStringDescription new.
	tmp2
		label: 'Superclass';
		priority: 2;
		accessor: #superclassName;
		blocCompletion: [ GtStringsCompletionStrategy new
					completions: GtPharoIndex current classNameTree ];
		blocShortcuts: [ | tmp4 tmp6 tmp8 |
				tmp4 := BlShortcutWithAction new.
				tmp4
					name: 'Browse class';
					description: 'Browses the class indicated by the editor';
					combination: BlKeyCombination primaryB.
				tmp6 := BlShortcutWithAction new.
				tmp6
					name: 'Inspect class';
					description: 'Inspects the class indicated by the editor';
					combination: BlKeyCombination primaryG.
				tmp8 := BlShortcutWithAction new.
				tmp8
					name: 'Browse class references';
					description: 'Browses references to the class indicated by the editor';
					combination: BlKeyCombination primaryN.
				{tmp4
						action: [ :arg1 | 
							arg1 target phlow
								spawnTool: (GtClassCoderTool forClass: arg1 target text asString asClass) ].
					tmp6
						action: [ :arg2 | arg2 target phlow spawnObject: arg2 target text asString asClass ].
					tmp8
						action: [ :arg3 | arg3 target phlow spawnObject: arg3 target text asString asClass gtReferences ]} ];
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize
					+ (BrGlamorousWithContextMenuAptitude
							content: [ BrGlamorousSimpleContextMenuContent new
									items: self contextMenuItemsForSuperclass ]) ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		addCondition: [ :arg4 | (Smalltalk classNamed: arg4 trim) isNotNil ]
			labelled: 'Unknown class';
		addCondition: [ :arg5 | 
					| tmp9 |
					tmp9 := Smalltalk classNamed: arg5 trim.
					tmp9 isNil or: [ tmp9 isClass ] ]
			labelled: 'Must be a class';
		addCondition: [ :arg6 | 
					| tmp10 |
					tmp10 := Smalltalk classNamed: arg6 trim.
					tmp10 isNil or: [ tmp10 isInstanceSide ] ]
			labelled: 'Must be an instance-side class'.
	^ tmp2 beRequired
]

{ #category : #accessing }
GtClassCreationForm >> superclassName [
	^ superclassName
]

{ #category : #accessing }
GtClassCreationForm >> superclassName: arg1 [
	superclassName := arg1
]
