enum ThemeType { moca, olive }

class AppSettings {
  final bool notifyMonthBefore;
  final bool notifyTwoWeeksBefore;
  final bool notifyDayBefore;
  final bool notifyOnDay;
  final bool emailNotification;
  final ThemeType themeType;

  const AppSettings({
    this.notifyMonthBefore = true,
    this.notifyTwoWeeksBefore = true,
    this.notifyDayBefore = true,
    this.notifyOnDay = true,
    this.emailNotification = false,
    this.themeType = ThemeType.moca,
  });

  AppSettings copyWith({
    bool? notifyMonthBefore,
    bool? notifyTwoWeeksBefore,
    bool? notifyDayBefore,
    bool? notifyOnDay,
    bool? emailNotification,
    ThemeType? themeType,
  }) =>
      AppSettings(
        notifyMonthBefore: notifyMonthBefore ?? this.notifyMonthBefore,
        notifyTwoWeeksBefore: notifyTwoWeeksBefore ?? this.notifyTwoWeeksBefore,
        notifyDayBefore: notifyDayBefore ?? this.notifyDayBefore,
        notifyOnDay: notifyOnDay ?? this.notifyOnDay,
        emailNotification: emailNotification ?? this.emailNotification,
        themeType: themeType ?? this.themeType,
      );

  Map<String, dynamic> toJson() => {
        'notifyMonthBefore': notifyMonthBefore,
        'notifyTwoWeeksBefore': notifyTwoWeeksBefore,
        'notifyDayBefore': notifyDayBefore,
        'notifyOnDay': notifyOnDay,
        'emailNotification': emailNotification,
        'themeType': themeType.name,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        notifyMonthBefore: json['notifyMonthBefore'] as bool? ?? true,
        notifyTwoWeeksBefore: json['notifyTwoWeeksBefore'] as bool? ?? true,
        notifyDayBefore: json['notifyDayBefore'] as bool? ?? true,
        notifyOnDay: json['notifyOnDay'] as bool? ?? true,
        emailNotification: json['emailNotification'] as bool? ?? false,
        themeType: json['themeType'] == 'olive' ? ThemeType.olive : ThemeType.moca,
      );
}
