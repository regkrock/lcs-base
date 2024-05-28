Class {
	#name : #GtPharoPackageDependencyElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'packageDependency',
		'header'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Views'
}

{ #category : #initialization }
GtPharoPackageDependencyElement >> initialize [
	| tmp2 |
	super initialize.
	self
		alignTopCenter;
		matchParent;
		cellSpacing: 20;
		padding: (BlInsets left: 20 right: 20);
		background: Color white.
	tmp2 := BrVerticalPane new.
	tmp2
		fitContent;
		alignCenter;
		padding: (BlInsets
					top: 10
					bottom: 10
					left: 20
					right: 20);
		background: Color white;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
	header := tmp2 addAptitude: BrShadowAptitude.
	self addChild: header
]

{ #category : #accessing }
GtPharoPackageDependencyElement >> packageDependency [
	^ packageDependency
]

{ #category : #accessing }
GtPharoPackageDependencyElement >> packageDependency: arg1 [
	| tmp2 tmp4 tmp6 tmp8 |
	packageDependency := arg1.
	header removeChildren.
	tmp2 := BrHorizontalPane new.
	tmp2
		fitContent;
		alignCenter.
	tmp4 := BrButton new.
	tmp4
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		label: packageDependency packageName.
	tmp6 := BrLabel new.
	tmp6 aptitude: BrGlamorousLabelAptitude.
	tmp8 := BrButton new.
	tmp8
		aptitude: BrGlamorousLinkButtonWithLabelAptitude;
		label: packageDependency dependencyPackageName.
	header
		addChild: (tmp2
				addChildren: {tmp4 action: [ :arg2 | arg2 phlow spawnObject: packageDependency package ].
						tmp6 text: 'depends on'.
						tmp8
							action: [ :arg3 | arg3 phlow spawnObject: packageDependency dependencyPackage ]}).
	packageDependency baselineStatuses
		do: [ :arg4 | 
			| tmp10 tmp12 |
			tmp10 := BrHorizontalPane new.
			tmp10
				fitContent;
				margin: (BlInsets top: 10);
				alignCenter.
			tmp12 := BrLabel new.
			tmp12 aptitude: BrGlamorousLabelAptitude.
			tmp10 addChild: (tmp12 text: arg4 statusPrefix uncapitalized).
			header
				addChild: (tmp10
						addChildren: (arg4 baselines asArray
								collect: [ :arg5 | 
									| tmp14 |
									tmp14 := BrButton new.
									tmp14
										aptitude: BrGlamorousLinkButtonWithLabelAptitude;
										label: arg5 name;
										action: [ :arg6 | arg6 phlow spawnTool: (GtClassCoderTool forClass: arg5) ] ])) ].
	(packageDependency gtDependenciesFor: GtPhlowEmptyView new)
		asElementDo: [ :arg7 | 
			arg7
				vFitContentLimited;
				hMatchParent;
				padding: (BlInsets
							top: 10
							bottom: 10
							left: 10
							right: 10);
				background: Color white;
				addAptitude: BrShadowAptitude;
				geometry: (BlRoundedRectangleGeometry cornerRadius: 10).
			self addChild: arg7 ]
]
