// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:io';

final goldensDir = Directory('test/visual/goldens');
final failuresDir = Directory('test/visual/failures');
final reportDir = Directory('test/visual/ui_changes');
final cacheRoot = Directory('${Directory.systemTemp.path}/cached_goldens');

Future<void> main(List<String> args) async {
  await createVisualChangesReport();
}

Future<void> createVisualChangesReport() async {
  if (!failuresDir.existsSync()) {
    stderr.writeln('Error: ${failuresDir.path} does not exist');
    exit(2);
  }

  final testImages = failuresDir.listSync().where((x) => x is File && x.path.endsWith('_testImage.png'));
  if (testImages.isEmpty) {
    stderr.writeln('Error: ${failuresDir.path} does not contain any failure images');
    exit(2);
  }

  if (reportDir.existsSync()) {
    await reportDir.delete(recursive: true);
  }
  await reportDir.create();

  for (final testImage in testImages) {
    final masterImage = File(testImage.path.replaceFirst('_testImage.png', '_masterImage.png'));
    final isolatedDiff = File(testImage.path.replaceFirst('_testImage.png', '_isolatedDiff.png'));
    final changesImageName = testImage.name.replaceFirst('_testImage.png', '.png');

    await exec(
      'convert',
      [
        masterImage.name,
        isolatedDiff.name,
        testImage.name,
        '+append',
        '../ui_changes/$changesImageName',
      ],
      workingDirectory: failuresDir.path,
    );

    print('  $changesImageName');
  }
}

Future<String> exec(String executable, List<String> arguments, {String? workingDirectory}) async {
  final processResult = await Process.run(executable, arguments, workingDirectory: workingDirectory);
  if (processResult.exitCode != 0) {
    throw Exception(
      '''
      ${commandLine(executable, arguments)}
      failed with exit code ${processResult.exitCode}
      stdout:
      ${indent(processResult.stdout as String)}
      stderr:
      ${indent(processResult.stderr as String)}
      ''',
    );
  }
  return (processResult.stdout as String).trim();
}

String commandLine(String executable, List<String> arguments) {
  return [executable, ...arguments].map((s) {
    if (s.contains(' ')) {
      return "'$s'";
    }
    return s;
  }).join(' ');
}

String indent(String s) => s.split('\n').map((line) => '    $line').join('\n');

extension NameExtension on FileSystemEntity {
  String get name => path.substring(path.lastIndexOf('/') + 1);
}
